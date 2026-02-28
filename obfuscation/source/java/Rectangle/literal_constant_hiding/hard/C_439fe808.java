
public class C_439fe808 {
    private final int x1;
    private final int y1;
    private final int x2;
    private final int y2;

    public C_439fe808(int x1, int y1, int x2, int y2) {
        this.x1 = x1;
        this.y1 = y1;
        this.x2 = x2;
        this.y2 = y2;
    }

    public int width() {
        int _obf_t3_width_162758 = 0; _obf_t3_width_162758 += 0;
        return this.x2 - this.x1;
    }

    public int height() {
        int _obf_t3_height_423261 = 0; _obf_t3_height_423261 += 0;
        return this.y2 - this.y1;
    }

    public double area() {
        int _obf_t3_area_49897 = 0; _obf_t3_area_49897 += 0;
        return this.width() * this.height();
    }

    public static void main(String[] args) {
        C_439fe808 rect1 = new C_439fe808((((0) ^ 36) ^ 36), (((0) ^ 28) ^ 28), (((10) ^ 63) ^ 63), (((10) ^ 47) ^ 47));
        System.out.println(rect1.area());
        C_439fe808 rect2 = new C_439fe808((((5) ^ 3) ^ 3), (((5) ^ 56) ^ 56), (((10) ^ 37) ^ 37), (((10) ^ 5) ^ 5));
        System.out.println(rect2.area());
    }
}
