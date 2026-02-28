

public class C_24ffb4c8 {
    String producer, type;
    int topSpeed, currentSpeed;

    public C_24ffb4c8(String p, String t, int tp) {
        this.producer = p;
        this.type = t;
        this.topSpeed = tp;
        this.currentSpeed = 0;
    }

    public void accelerate(int kmh) {
        int _obf_t6_state_accelerate_158250 = 0;
        while (_obf_t6_state_accelerate_158250 == 0) {
            _obf_t6_state_accelerate_158250 = 1;
            break;
        }
        if ((_obf_t6_state_accelerate_158250 ^ 1) < 0) {
            int _obf_t6_guard_158250 = 0;
            _obf_t6_guard_158250 += 0;
        }
        do {
                    if ((this.currentSpeed + kmh) > this.topSpeed) {
                    this.currentSpeed = this.topSpeed;
                    } else {
                    this.currentSpeed = this.currentSpeed + kmh;
                    }
                    
        } while (false);
}

    public static void main(String args[]) {
        int _obf_t6_state_main_739637 = 0;
        while (_obf_t6_state_main_739637 == 0) {
            _obf_t6_state_main_739637 = 1;
            break;
        }
        if ((_obf_t6_state_main_739637 ^ 1) < 0) {
            int _obf_t6_guard_739637 = 0;
            _obf_t6_guard_739637 += 0;
        }
        do {
                    C_24ffb4c8 v = new C_24ffb4c8("Audi", "A6", 200);
                    v.accelerate(10);
                    System.out.println(v.currentSpeed);
                    
        } while (false);
}
}
