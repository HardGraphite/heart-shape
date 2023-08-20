X_MIN = -1.3
X_MAX = 1.3
Y_MIN = -1.1
Y_MAX = 1.4

def f(x, y)
  x2 = x * x
  y2 = y * y
  y3 = y2 * y

  t_1 = x2 + y2 - 1.0
  t_2 = x2 * y3
  t_1 * t_1 * t_1 - t_2
end

def draw(stream)
  width, height = 80, 24

  x_step = (X_MAX - X_MIN) / (width - 1.0)
  y_step = (Y_MAX - Y_MIN) / (height - 1.0)

  height.times do |i|
    y = Y_MAX - y_step * i
    width.times do |j|
      x = X_MIN + x_step * j
      stream.print(f(x, y) <= 0.0 ? "@" : " ")
    end
    stream.puts
  end
end

draw($stdout)
