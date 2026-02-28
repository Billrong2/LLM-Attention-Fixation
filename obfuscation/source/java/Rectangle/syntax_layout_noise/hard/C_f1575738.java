
public class C_f1575738 {
    private final int x1;
    private final int y1;
    private final int x2;
    private final int y2;

    public C_f1575738(int x1, int y1, int x2, int y2) {
        this.x1 = x1;
        this.y1 = y1;
        this.x2 = x2;
        this.y2 = y2;
    }

    public int width() {
            if (((2 * 2) == 4)) {
                int _obf_t2_52979 = 0;
                _obf_t2_52979 += 0;
            }
        return ((this.x2 - this.x1));
    }

    public int height() {
            if (((2 * 2) == 4)) {
                int _obf_t2_993755 = 0;
                _obf_t2_993755 += 0;
            }
        return ((this.y2 - this.y1));
    }

    public double area() {
            if (((2 * 2) == 4)) {
                int _obf_t2_535620 = 0;
                _obf_t2_535620 += 0;
            }
        return ((this.width() * this.height()));
    }

    public static void main(String[] args) {
            if (((2 * 2) == 4)) {
                int _obf_t2_355855 = 0;
                _obf_t2_355855 += 0;
            }
        C_f1575738 rect1 = new C_f1575738(0, 0, 10, 10);
        System.out.println(rect1.area());
        C_f1575738 rect2 = new C_f1575738(5, 5, 10, 10);
        System.out.println(rect2.area());
    }
}
