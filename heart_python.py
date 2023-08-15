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

    x_step = (X_MAX - X_MIN) / (width - 1)
    y_step = (Y_MIN - Y_MAX) / (height - 1)

    buffer = []
    for y in range(int(Y_MAX * 1e3), int(Y_MIN * 1e3), int(y_step * 1e3)):
        y /= 1e3
        for x in range(int(X_MIN * 1e3), int(X_MAX * 1e3), int(x_step * 1e3)):
            x /= 1e3
            buffer.append('@' if F(x, y) <= 0 else ' ')
        print(*buffer, sep='', file=stream)
        buffer.clear()


def main():
    stream = sys.stdout
    size = (*os.get_terminal_size(),) if stream.isatty() else None
    draw(stream, size)


if __name__ == '__main__':
    main()
