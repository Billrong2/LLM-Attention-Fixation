

public class C_2a37cfaf {
    String producer, type;
    int topSpeed, currentSpeed;

    public C_2a37cfaf(String p, String t, int tp) {
        this.producer = p;
        this.type = t;
        this.topSpeed = tp;
        this.currentSpeed = 0;
    }

    public void accelerate(int kmh) {
        int _obf_t4_accelerate_921713 = 0; _obf_t4_accelerate_921713 += 0;
        if ((this.currentSpeed + kmh) > this.topSpeed) {
            this.currentSpeed = this.topSpeed;
        } else {
            this.currentSpeed = this.currentSpeed + kmh;
        }
    }

    public static void main(String args[]) {
        C_2a37cfaf v = new C_2a37cfaf("Audi", "A6", ((((200) ^ 16) ^ 16) + 0));
        v.accelerate(10);
        System.out.println(v.currentSpeed);
    }
}
