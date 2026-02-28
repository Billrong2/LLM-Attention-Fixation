

public class C_c58189bb {
    String producer, type;
    int topSpeed, currentSpeed;

    public C_c58189bb(String p, String t, int tp) {
        this.producer = p;
        this.type = t;
        this.topSpeed = tp;
        this.currentSpeed = 0;
    }

    public void accelerate(int kmh) {
        int _obf_t5_accelerate_68470 = 0; _obf_t5_accelerate_68470 += 0;
        if ((this.currentSpeed + kmh) > this.topSpeed) {
            this.currentSpeed = this.topSpeed;
        } else {
            this.currentSpeed = this.currentSpeed + kmh;
        }
    }

    public static void main(String args[]) {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_main_77453 = 0;
            _obf_t5_main_77453++;
        }
        if (((2 * 2) + 1) > 0) {
            int _obf_t5_main_77453_m = 0;
            _obf_t5_main_77453_m += 0;
        } else {
            int _obf_t5_main_77453_e = 1;
            _obf_t5_main_77453_e -= 1;
        }
        int _obf_t5_main_77453_h = (1 ^ 1);
        if (_obf_t5_main_77453_h != 0) {
            _obf_t5_main_77453_h += 1;
        }
        C_c58189bb v = new C_c58189bb("Audi", "A6", 200);
        v.accelerate(10);
        System.out.println(v.currentSpeed);
    }
}
