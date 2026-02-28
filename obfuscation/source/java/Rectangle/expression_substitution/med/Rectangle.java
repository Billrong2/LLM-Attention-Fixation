
public class Rectangle {
    private final int x1;
    private final int y1;
    private final int x2;
    private final int y2;

    public Rectangle(int x1, int y1, int x2, int y2) {
        this.x1 = x1;
        this.y1 = y1;
        this.x2 = x2;
        this.y2 = y2;
    }

    public int width() {
        int _obf_t4_width_210119 = 0; _obf_t4_width_210119 += 0;
        return this.x2 - this.x1;
    }

    public int height() {
        int _obf_t4_height_548900 = 0; _obf_t4_height_548900 += 0;
        return this.y2 - this.y1;
    }

    public double area() {
        int _obf_t4_area_887318 = 0; _obf_t4_area_887318 += 0;
        return this.width() * this.height();
    }

    public static void main(String[] args) {
        Rectangle rect1 = new Rectangle((((0) ^ 14) ^ 14), 0, (((10) ^ 24) ^ 24), (((10) ^ 10) ^ 10));
        System.out.println(rect1.area());
        Rectangle rect2 = new Rectangle((((5) ^ 24) ^ 24), 5, (((10) ^ 27) ^ 27), 10);
        System.out.println(rect2.area());
    }
}
