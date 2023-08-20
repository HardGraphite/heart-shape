import java.io.PrintStream;

public class heart_java {
    private static final double X_MIN = -1.3;
    private static final double X_MAX = -X_MIN;
    private static final double Y_MIN = -1.1;
    private static final double Y_MAX = 1.4;

    private static double F(double x, double y) {
        double x2 = x * x;
        double y2 = y * y;
        double y3 = y2 * y;

        double t_1 = x2 + y2 - 1;
        double t_2 = x2 * y3;
        return t_1 * t_1 * t_1 - t_2;
    }

    public static void draw(PrintStream stream) {
        int width = 80, height = 24;

        double x_step = (X_MAX - X_MIN) / ((double)width - 1);
        double y_step = (Y_MAX - Y_MIN) / ((double)height - 1);

        for (double y = Y_MAX; y > Y_MIN; y -= y_step) {
            for (double x = X_MIN; x < X_MAX; x += x_step) {
                stream.print(F(x, y) <= 0 ? '@' : ' ');
            }
            stream.print('\n');
        }
    }

    public static void main(String[] args) {
        draw(System.out);
    }
}
