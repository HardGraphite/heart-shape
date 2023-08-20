use std::io::{self, Write};

const X_MIN: f64 = -1.3;
const X_MAX: f64 = 1.3;
const Y_MIN: f64 = -1.1;
const Y_MAX: f64 = 1.4;

fn f(x: f64, y: f64) -> f64 {
    let x2 = x * x;
    let y2 = y * y;
    let y3 = y2 * y;

    let t_1 = x2 + y2 - 1.0;
    let t_2 = x2 * y3;
    t_1 * t_1 * t_1 - t_2
}

fn draw<W: Write>(mut stream: W) {
    let (width, height) = (80, 24);

    let x_step = (X_MAX - X_MIN) / (width as f64 - 1.0);
    let y_step = (Y_MAX - Y_MIN) / (height as f64 - 1.0);

    for i in 0..height {
        let y = Y_MAX - y_step * i as f64;
        for j in 0..width {
            let x = X_MIN + x_step * j as f64;
            if f(x, y) <= 0.0 {
                write!(stream, "@").unwrap();
            } else {
                write!(stream, " ").unwrap();
            }
        }
        writeln!(stream).unwrap();
    }
}

fn main() {
    let stdout = io::stdout();
    draw(stdout.lock());
}
