import os
from glob import glob
import numpy as np
from plotly import graph_objects as go

import tensorflow as tf


NUM_SAMPLES = 220500  # 5 seconds of mono 44.1 kHz audio


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

    # TODO: Normalize peak volume

    return samples


if __name__ == '__main__':
    bytestreams = {}

    print('CWD:', os.getcwd())

    for fname in glob('assets/*'):
        print('FILE:', fname)
        bytestreams[fname] = get_mono_sample_array(fname)

    dataset = tf.data.Dataset.from_tensor_slices(bytestreams)
