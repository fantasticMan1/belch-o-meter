import os
import glob
import numpy as np

import tensorflow as tf


bytestreams = {}

print('CWD:', os.getcwd())


def _get_byte_stream(fname):
    with open(fname, 'rb') as f:
        return f.read()


def _normalize(stream: bytes) -> bytes:
    return stream


for fname in glob.glob('assets/*'):
    print('Reading file:', fname)

    bytestreams[fname] = _get_byte_stream(fname)

    for name in bytestreams:
        bytestreams[name] = _normalize(bytestreams[name])
        print(name, len(bytestreams[name]))
