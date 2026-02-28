

public class C_d2ac3f2e {
    String producer, type;
    int topSpeed, currentSpeed;

    public C_d2ac3f2e(String p, String t, int tp) {
        this.producer = p;
        this.type = t;
        this.topSpeed = tp;
        this.currentSpeed = 0;
    }

    public void accelerate(int p_O00OI1) {
        if ((this.currentSpeed + p_O00OI1) > this.topSpeed) {
            this.currentSpeed = this.topSpeed;
        } else {
            this.currentSpeed = this.currentSpeed + p_O00OI1;
        }
    }

    public static void main(String p_10O011[]) {
        C_d2ac3f2e _O100I1 = new C_d2ac3f2e("Audi", "A6", 200);
        _O100I1.accelerate(10);
        System.out.println(_O100I1.currentSpeed);
    }
}
