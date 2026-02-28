

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
        int _obf_t4_accelerate_921713 = 0; _obf_t4_accelerate_921713 += 0;
        if ((this.currentSpeed + kmh) > this.topSpeed) {
            this.currentSpeed = this.topSpeed;
        } else {
            this.currentSpeed = this.currentSpeed + kmh;
        }
    }

    public static void main(String args[]) {
        Vehicle v = new Vehicle("Audi", "A6", ((200) + 0));
        v.accelerate(((10) + 0));
        System.out.println(v.currentSpeed);
    }
}
