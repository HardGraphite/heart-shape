#include <stdbool.h>
#include <stdio.h>

#if defined _WIN32
#    include <io.h>
#    include <Windows.h>
#elif defined __unix__ || defined __APPLE__
#    include <sys/ioctl.h>
#    include <unistd.h>
#endif

static bool stdout_is_tty(void) {
#if defined(_POSIX_VERSION)
    return isatty(STDOUT_FILENO);
#elif defined(_WIN32)
    return _isatty(_fileno(stdout));
#else
    return false;
#endif
}

struct canvas_size {
    unsigned int width, height;
};

static bool stdout_term_size(struct canvas_size *size) {
#if defined(_POSIX_VERSION)
    struct winsize w;
    if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &w) == -1)
        return false;
    size->width  = w.ws_col;
    size->height = w.ws_row;
    return true;
#elif defined(_WIN32)
    CONSOLE_SCREEN_BUFFER_INFO csbi;
    if (!GetConsoleScreenBufferInfo(GetStdHandle(STD_OUTPUT_HANDLE), &csbi))
        return false;
    size->width  = (unsigned int)(csbi.srWindow.Right - csbi.srWindow.Left + 1);
    size->height = (unsigned int)(csbi.srWindow.Bottom - csbi.srWindow.Top + 1);
    return true;
#else
    return false;
#endif
}

static double F(double x, double y) {
    const double x2 = x * x;  // x^2
    const double y2 = y * y;  // y^2
    const double y3 = y2 * y; // y^3

    const double t_1 = x2 + y2 - 1; // x^2 + y^2 - 1
    const double t_2 = x2 * y3;     // x^2 - y^3
    return t_1 * t_1 * t_1 - t_2;
}

#define X_MAX  1.3
#define X_MIN  (-X_MAX)
#define Y_MAX  1.4
#define Y_MIN  -1.1

static void draw(FILE *stream, struct canvas_size canvas_size) {
    const double x_scale = (double)canvas_size.width / (X_MAX - X_MIN);
    const double x_start = -(double)canvas_size.width / 2;
    const double x_stop  = -x_start;

    const double y_scale = (double)canvas_size.height / (Y_MAX - Y_MIN);
    const double y_start = (double)canvas_size.height * Y_MAX / (Y_MAX - Y_MIN);
    const double y_stop  = (double)canvas_size.height * Y_MIN / (Y_MAX - Y_MIN);

    for (double y1 = y_start; y1 > y_stop; y1--) {
        const double y = y1 / y_scale;
        for (double x1 = x_start; x1 < x_stop; x1++) {
            const double x = x1 / x_scale;
            fputc(F(x, y) <= 0 ? '@' : ' ', stream);
        }
        fputc('\n', stream);
    }
}

int main(void) {
    struct canvas_size canvas_size;
    if (!(stdout_is_tty() && stdout_term_size(&canvas_size)))
        canvas_size.width = 80, canvas_size.height = 24;
    draw(stdout, canvas_size);
}
