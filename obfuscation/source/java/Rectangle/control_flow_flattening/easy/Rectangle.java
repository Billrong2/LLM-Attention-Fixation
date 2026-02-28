
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
        do {
            {
                int _obf_t6_easy_743592 = 0;
                _obf_t6_easy_743592 += 0;
                    return this.x2 - this.x1;
                    
            }
        } while (false);
}

    public int height() {
        do {
            {
                int _obf_t6_easy_339069 = 0;
                _obf_t6_easy_339069 += 0;
                    return this.y2 - this.y1;
                    
            }
        } while (false);
}

    public double area() {
        do {
            {
                int _obf_t6_easy_646243 = 0;
                _obf_t6_easy_646243 += 0;
                    return this.width() * this.height();
                    
            }
        } while (false);
}

    public static void main(String[] args) {
        do {
            {
                int _obf_t6_easy_829790 = 0;
                _obf_t6_easy_829790 += 0;
                    Rectangle rect1 = new Rectangle(0, 0, 10, 10);
                    System.out.println(rect1.area());
                    Rectangle rect2 = new Rectangle(5, 5, 10, 10);
                    System.out.println(rect2.area());
                    
            }
        } while (false);
}
}
