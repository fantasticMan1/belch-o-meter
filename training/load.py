import os
import sys
from glob import glob
# import numpy as np
# from plotly import graph_objects as go
from scipy.fft import fft
# from random import randint

import tensorflow as tf


DEFAULT_TRAINING_DATA_PATH = '~/Dropbox/belch_o_meter_training_data/'
NUM_SAMPLES = 220500  # 5 seconds of mono 44.1 kHz audio

def get_training_data_path():
    path = os.path.expanduser(DEFAULT_TRAINING_DATA_PATH)

    if len(sys.argv) > 1:
        if isinstance(sys.argv[1], str) and os.path.exists(sys.argv[1]):
            path = sys.argv[1]
            if path[-1] != '/':
                path.append('/')
        else:
            print(
                f'Warning: Invalid path: {sys.argv[1]}\n'
                + f'Proceeding with {path}...'
            )

    return path

def get_mono_sample_array(fname):
    # TODO: assert that fname is wav file

    with open(fname, 'rb') as f:
        bytestream = f.read()

        num_channels = int.from_bytes(bytestream[22:23], 'little')
        print('CHANNELS:', num_channels)

        bit_depth = int.from_bytes(bytestream[34:35], 'little')
        print('BIT DEPTH:', bit_depth)
        bytes_per_sample = bit_depth // 8

        subchunk1_size = int.from_bytes(bytestream[16:20], 'little')
        header_size = subchunk1_size + 28
        bytestream = bytestream[header_size:]  # Discard header

        samples = []
        for i in range(0, len(bytestream) // bytes_per_sample, bytes_per_sample):
            samples.append(int.from_bytes(
                bytestream[i:i+bytes_per_sample],
                'little',
            ))
        
        samples = samples[::num_channels]  # Convert to mono by using first channel only

        return normalize(samples)


def normalize(samples):
    if len(samples) > NUM_SAMPLES:
        samples = samples[:NUM_SAMPLES]
    elif len(samples) < NUM_SAMPLES:
        diff = NUM_SAMPLES - len(samples)
        samples.extend([0] * diff)

    m = float(max(samples))
    normalized = [n / m for n in samples]
    return normalized


if __name__ == '__main__':
    path = get_training_data_path()

    samples = {}

    files = glob(path + '*.wav')
    print(os.listdir(path))
    if not files:
        raise RuntimeError(f'No .wav files found in {path}')

    for fname in files:
        print('FILE:', fname)
        name = fname.replace(path, '').replace('.wav', '')
        samples[name] = get_mono_sample_array(fname)

    spectra = {}

    for name, sample_array in samples.items():
        spectrum = abs(fft(sample_array))

        truncated_spectrum = []
        for i in range(0, len(spectrum), 100):
            truncated_spectrum.append(
                sum(spectrum[i:i+100]) / len(spectrum[i:i+100])
            )

        spectra[name] = truncated_spectrum

    labels = [float(a[0]) for a in spectra.keys()]

    model = tf.keras.Sequential([
        tf.keras.layers.Dense(NUM_SAMPLES),
        tf.keras.layers.Dense(128),
        tf.keras.layers.Dense(16),
        tf.keras.layers.Dense(6),
    ])
    loss_fn = tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True)
    model.compile(
        optimizer='adam',
        loss=loss_fn,
        metrics=['accuracy'],
    )
    model.fit(
        list(spectra.values()),
        labels,
        epochs=3,
    )
    model.summary()

    print('PREDICTION:', model.predict(list(spectra.values())[:1]))
    print('ACTUAL:', list(spectra.keys())[:1])

    converter = tf.lite.TFLiteConverter.from_keras_model(model)
    tflite_model = converter.convert()

    # Save the model.
    with open('model.tflite', 'wb') as f:
        print('OPENING FILE')
        f.write(tflite_model)
