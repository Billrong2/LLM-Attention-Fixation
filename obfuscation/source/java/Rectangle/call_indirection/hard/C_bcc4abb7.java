
public class C_bcc4abb7 {
    private final int x1;
    private final int y1;
    private final int x2;
    private final int y2;

    public C_bcc4abb7(int x1, int y1, int x2, int y2) {
        this.x1 = x1;
        this.y1 = y1;
        this.x2 = x2;
        this.y2 = y2;
    }

    public int width() {
        int _obf_t8_width_740776 = 0; _obf_t8_width_740776 += 0;
        return this.x2 - this.x1;
    }

    public int height() {
        int _obf_t8_height_75226 = 0; _obf_t8_height_75226 += 0;
        return this.y2 - this.y1;
    }

    public double area() {
        int _obf_t8_area_492318 = 0; _obf_t8_area_492318 += 0;
        return this.width() * this.height();
    }

    public static void main(String[] args) {
        int _obf_t8_main_30554 = 0; _obf_t8_main_30554 += 0;
        C_bcc4abb7 rect1 = new C_bcc4abb7(0, 0, 10, 10);
        System.out.println(rect1.area());
        C_bcc4abb7 rect2 = new C_bcc4abb7(5, 5, 10, 10);
        System.out.println(rect2.area());
    }
}
