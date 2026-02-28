

public class Vehicle {
    String producer, type;
    int topSpeed, currentSpeed;

    public Vehicle(String p, String t, int tp) {
        this.producer = p;
        this.type = t;
        this.topSpeed = tp;
        this.currentSpeed = 0;
    }

    public void accelerate(int kmh) {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_accelerate_164032 = 0;
            _obf_t5_accelerate_164032++;
        }
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
        Vehicle v = new Vehicle("Audi", "A6", 200);
        v.accelerate(10);
        System.out.println(v.currentSpeed);
    }
}
