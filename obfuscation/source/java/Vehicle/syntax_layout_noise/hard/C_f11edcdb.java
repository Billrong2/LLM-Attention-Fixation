

public class C_f11edcdb {
    String producer, type;
    int topSpeed, currentSpeed;

    public C_f11edcdb(String p, String t, int tp) {
        this.producer = p;
        this.type = t;
        this.topSpeed = tp;
        this.currentSpeed = 0;
    }

    public void accelerate(int kmh) {
            if (((2 * 2) == 4)) {
                int _obf_t2_692566 = 0;
                _obf_t2_692566 += 0;
            }
        if ((this.currentSpeed + kmh) > this.topSpeed) {
            this.currentSpeed = this.topSpeed;
        } else {
            this.currentSpeed = this.currentSpeed + kmh;
        }
    }

    public static void main(String args[]) {
            if (((2 * 2) == 4)) {
                int _obf_t2_386962 = 0;
                _obf_t2_386962 += 0;
            }
        C_f11edcdb v = new C_f11edcdb("Audi", "A6", 200);
        v.accelerate(10);
        System.out.println(v.currentSpeed);
    }
}
