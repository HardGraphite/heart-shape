#!/usr/bin/python

import os
import sys
from typing import TextIO


F = lambda x, y: (x ** 2 + y ** 2 - 1) ** 3 - x ** 2 * y ** 3
X_MIN = -1.3
X_MAX = -X_MIN
Y_MIN = -1.1
Y_MAX = 1.4


def draw(stream: TextIO, size: tuple[int, int] | None):
    if size is None:
        width, height = 80, 24
    else:
        width, height = size

    x_scale = width / (X_MAX - X_MIN)
    x_start = -width / 2
    x_stop = -x_start

    y_scale = height / (Y_MAX - Y_MIN)
    y_start = height * Y_MAX / (Y_MAX - Y_MIN)
    y_stop = height * Y_MIN / (Y_MAX - Y_MIN)

    buffer = []
    for y in range(int(y_start * 100), int(y_stop * 100), -100):
        y = y / 100 / y_scale
        for x in range(int(x_start * 100), int(x_stop * 100), 100):
            x = x / 100 / x_scale
            buffer.append('@' if F(x, y) <= 0 else ' ')
        print(*buffer, sep='', file=stream)
        buffer.clear()


def main():
    stream = sys.stdout
    size = (*os.get_terminal_size(),) if stream.isatty() else None
    draw(stream, size)


if __name__ == '__main__':
    main()
