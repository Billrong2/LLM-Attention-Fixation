
public class C_29f098b9 {
    private final int x1;
    private final int y1;
    private final int x2;
    private final int y2;

    public C_29f098b9(int x1, int y1, int x2, int y2) {
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
        C_29f098b9 rect1 = new C_29f098b9(((((0) ^ 26) ^ 26) + 0), 0, ((((10) ^ 46) ^ 46) + 0), ((((10) ^ 18) ^ 18) + 0));
        System.out.println(rect1.area());
        C_29f098b9 rect2 = new C_29f098b9(((((5) ^ 46) ^ 46) + 0), 5, ((((10) ^ 53) ^ 53) + 0), 10);
        System.out.println(rect2.area());
    }
}
