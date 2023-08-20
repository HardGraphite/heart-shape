package main

import (
	"os"
)

const (
	X_MIN = -1.3
	X_MAX = 1.3
	Y_MIN = -1.1
	Y_MAX = 1.4
)

func F(x, y float64) float64 {
	x2 := x * x
	y2 := y * y
	y3 := y2 * y

	t_1 := x2 + y2 - 1
	t_2 := x2 * y3
	return t_1*t_1*t_1 - t_2
}

func draw(stream *os.File) {
	width, height := 80, 24

	x_step := (X_MAX - X_MIN) / float64(width-1)
	y_step := (Y_MAX - Y_MIN) / float64(height-1)

	for y := Y_MAX; y > Y_MIN; y -= y_step {
		for x := X_MIN; x < X_MAX; x += x_step {
			if F(x, y) <= 0 {
				stream.WriteString("@");
			} else {
				stream.WriteString(" ");
			}
		}
                stream.WriteString("\n")
	}
}

func main() {
	draw(os.Stdout)
}
