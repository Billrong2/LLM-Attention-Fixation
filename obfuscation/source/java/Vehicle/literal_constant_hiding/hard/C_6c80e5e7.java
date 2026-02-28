

public class C_6c80e5e7 {
    String producer, type;
    int topSpeed, currentSpeed;

    public C_6c80e5e7(String p, String t, int tp) {
        this.producer = p;
        this.type = t;
        this.topSpeed = tp;
        this.currentSpeed = 0;
    }

    public void accelerate(int kmh) {
        int _obf_t3_accelerate_66068 = 0; _obf_t3_accelerate_66068 += 0;
        if ((this.currentSpeed + kmh) > this.topSpeed) {
            this.currentSpeed = this.topSpeed;
        } else {
            this.currentSpeed = this.currentSpeed + kmh;
        }
    }

    public static void main(String args[]) {
        C_6c80e5e7 v = new C_6c80e5e7(_obf_t3_dec_623943("QXVkaQ=="), _obf_t3_dec_623943("QTY="), (((200) ^ 19) ^ 19));
        v.accelerate((((10) ^ 39) ^ 39));
        System.out.println(v.currentSpeed);
    }


private static String _obf_t3_dec_623943(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
