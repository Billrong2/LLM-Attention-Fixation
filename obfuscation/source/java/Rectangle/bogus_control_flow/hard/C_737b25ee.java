
public class C_737b25ee {
    private final int x1;
    private final int y1;
    private final int x2;
    private final int y2;

    public C_737b25ee(int x1, int y1, int x2, int y2) {
        this.x1 = x1;
        this.y1 = y1;
        this.x2 = x2;
        this.y2 = y2;
    }

    public int width() {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_width_716831 = 0;
            _obf_t5_width_716831++;
        }
        if (((2 * 2) + 1) > 0) {
            int _obf_t5_width_716831_m = 0;
            _obf_t5_width_716831_m += 0;
        } else {
            int _obf_t5_width_716831_e = 1;
            _obf_t5_width_716831_e -= 1;
        }
        int _obf_t5_width_716831_h = (1 ^ 1);
        if (_obf_t5_width_716831_h != 0) {
            _obf_t5_width_716831_h += 1;
        }
        return this.x2 - this.x1;
    }

    public int height() {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_height_886674 = 0;
            _obf_t5_height_886674++;
        }
        if (((2 * 2) + 1) > 0) {
            int _obf_t5_height_886674_m = 0;
            _obf_t5_height_886674_m += 0;
        } else {
            int _obf_t5_height_886674_e = 1;
            _obf_t5_height_886674_e -= 1;
        }
        int _obf_t5_height_886674_h = (1 ^ 1);
        if (_obf_t5_height_886674_h != 0) {
            _obf_t5_height_886674_h += 1;
        }
        return this.y2 - this.y1;
    }

    public double area() {
        int _obf_t5_area_791434 = 0; _obf_t5_area_791434 += 0;
        return this.width() * this.height();
    }

    public static void main(String[] args) {
        int _obf_t5_main_791326 = 0; _obf_t5_main_791326 += 0;
        C_737b25ee rect1 = new C_737b25ee(0, 0, 10, 10);
        System.out.println(rect1.area());
        C_737b25ee rect2 = new C_737b25ee(5, 5, 10, 10);
        System.out.println(rect2.area());
    }
}
