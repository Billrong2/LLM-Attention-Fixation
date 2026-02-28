
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
        int _obf_t1_width_850819 = 0; _obf_t1_width_850819 += 0;
        return this.x2 - this.x1;
    }

    public int height() {
        int _obf_t1_height_840897 = 0; _obf_t1_height_840897 += 0;
        return this.y2 - this.y1;
    }

    public double area() {
        int _obf_t1_area_163620 = 0; _obf_t1_area_163620 += 0;
        return this.width() * this.height();
    }

    public static void main(String[] args) {
        Rectangle v1 = new Rectangle(0, 0, 10, 10);
        System.out.println(v1.area());
        Rectangle v2 = new Rectangle(5, 5, 10, 10);
        System.out.println(v2.area());
    }
}
