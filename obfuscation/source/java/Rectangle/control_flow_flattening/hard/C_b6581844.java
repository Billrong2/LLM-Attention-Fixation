
public class C_b6581844 {
    private final int x1;
    private final int y1;
    private final int x2;
    private final int y2;

    public C_b6581844(int x1, int y1, int x2, int y2) {
        this.x1 = x1;
        this.y1 = y1;
        this.x2 = x2;
        this.y2 = y2;
    }

    public int width() {
        int _obf_t6_state_width_743592 = 0;
        while (_obf_t6_state_width_743592 == 0) {
            _obf_t6_state_width_743592 = 1;
            break;
        }
        if ((_obf_t6_state_width_743592 ^ 1) < 0) {
            int _obf_t6_guard_743592 = 0;
            _obf_t6_guard_743592 += 0;
        }
        do {
                    return this.x2 - this.x1;
                    
        } while (false);
}

    public int height() {
        int _obf_t6_state_height_339069 = 0;
        while (_obf_t6_state_height_339069 == 0) {
            _obf_t6_state_height_339069 = 1;
            break;
        }
        if ((_obf_t6_state_height_339069 ^ 1) < 0) {
            int _obf_t6_guard_339069 = 0;
            _obf_t6_guard_339069 += 0;
        }
        do {
                    return this.y2 - this.y1;
                    
        } while (false);
}

    public double area() {
        int _obf_t6_area_958645 = 0; _obf_t6_area_958645 += 0;
        return this.width() * this.height();
    }

    public static void main(String[] args) {
        int _obf_t6_state_main_829790 = 0;
        while (_obf_t6_state_main_829790 == 0) {
            _obf_t6_state_main_829790 = 1;
            break;
        }
        if ((_obf_t6_state_main_829790 ^ 1) < 0) {
            int _obf_t6_guard_829790 = 0;
            _obf_t6_guard_829790 += 0;
        }
        do {
                    C_b6581844 rect1 = new C_b6581844(0, 0, 10, 10);
                    System.out.println(rect1.area());
                    C_b6581844 rect2 = new C_b6581844(5, 5, 10, 10);
                    System.out.println(rect2.area());
                    
        } while (false);
}
}
