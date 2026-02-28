
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
        int _obf_t6_state_width_743592 = 0;
        while (_obf_t6_state_width_743592 == 0) {
            _obf_t6_state_width_743592 = 1;
            break;
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
        do {
                    Rectangle rect1 = new Rectangle(0, 0, 10, 10);
                    System.out.println(rect1.area());
                    Rectangle rect2 = new Rectangle(5, 5, 10, 10);
                    System.out.println(rect2.area());
                    
        } while (false);
}
}
