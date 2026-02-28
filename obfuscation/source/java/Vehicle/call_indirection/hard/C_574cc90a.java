

public class C_574cc90a {
    String producer, type;
    int topSpeed, currentSpeed;

    public C_574cc90a(String p, String t, int tp) {
        this.producer = p;
        this.type = t;
        this.topSpeed = tp;
        this.currentSpeed = 0;
    }

    public void accelerate(int kmh) {
        int _obf_t8_accelerate_498243 = 0; _obf_t8_accelerate_498243 += 0;
        if ((this.currentSpeed + kmh) > this.topSpeed) {
            this.currentSpeed = this.topSpeed;
        } else {
            this.currentSpeed = this.currentSpeed + kmh;
        }
    }

    public static void main(String args[]) {
        int _obf_t8_main_576234 = 0; _obf_t8_main_576234 += 0;
        C_574cc90a v = new C_574cc90a("Audi", "A6", 200);
        v.accelerate(10);
        System.out.println(v.currentSpeed);
    }
}
