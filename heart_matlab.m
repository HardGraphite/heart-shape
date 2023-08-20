x = @(t) 16 * sin(t) ^ 3;
y = @(t) 13 * cos(t) - 5 * cos(2 * t) - 2 * cos(3 * t) - cos(t);
fplot(x, y, '-r');
axis off;
grid off;
