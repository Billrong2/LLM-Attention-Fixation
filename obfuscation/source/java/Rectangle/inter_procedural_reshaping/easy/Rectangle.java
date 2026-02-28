
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
        _obf_t7_hook_width_158302();
        return this.x2 - this.x1;
    }

    public int height() {
        _obf_t7_hook_height_35873();
        return this.y2 - this.y1;
    }

    public double area() {
        _obf_t7_hook_area_76158();
        return this.width() * this.height();
    }

    public static void main(String[] args) {
        _obf_t7_hook_main_209094();
        Rectangle rect1 = new Rectangle(0, 0, 10, 10);
        System.out.println(rect1.area());
        Rectangle rect2 = new Rectangle(5, 5, 10, 10);
        System.out.println(rect2.area());
    }


private static void _obf_t7_hook_main_209094() {
        int _obf_t7_209094 = 0;
        _obf_t7_209094 += 0;
    }

    private void _obf_t7_hook_area_76158() {
        int _obf_t7_76158 = 0;
        _obf_t7_76158 += 0;
    }

    private void _obf_t7_hook_height_35873() {
        int _obf_t7_35873 = 0;
        _obf_t7_35873 += 0;
    }

    private void _obf_t7_hook_width_158302() {
        int _obf_t7_158302 = 0;
        _obf_t7_158302 += 0;
    }
}
