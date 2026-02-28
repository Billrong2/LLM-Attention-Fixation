

public class C_9b9e2ee9 {
    String producer, type;
    int topSpeed, currentSpeed;

    public C_9b9e2ee9(String p, String t, int tp) {
        this.producer = p;
        this.type = t;
        this.topSpeed = tp;
        this.currentSpeed = 0;
    }

    public void accelerate(int kmh) {
        _obf_t7_hook_accelerate_648488();
        if ((this.currentSpeed + kmh) > this.topSpeed) {
            this.currentSpeed = this.topSpeed;
        } else {
            this.currentSpeed = this.currentSpeed + kmh;
        }
    }

    public static void main(String args[]) {
        _obf_t7_hook_main_541819();
        C_9b9e2ee9 v = new C_9b9e2ee9("Audi", "A6", 200);
        v.accelerate(10);
        System.out.println(v.currentSpeed);
    }


private static void _obf_t7_hook_main_541819() {
        int _obf_t7_541819 = 0;
        _obf_t7_541819 += 0;
    }

    private void _obf_t7_hook_accelerate_648488() {
        int _obf_t7_648488 = 0;
        _obf_t7_648488 += 0;
    }
}
