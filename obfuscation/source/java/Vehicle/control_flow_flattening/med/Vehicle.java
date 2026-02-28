

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
        int _obf_t6_state_accelerate_158250 = 0;
        while (_obf_t6_state_accelerate_158250 == 0) {
            _obf_t6_state_accelerate_158250 = 1;
            break;
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
        do {
                    Vehicle v = new Vehicle("Audi", "A6", 200);
                    v.accelerate(10);
                    System.out.println(v.currentSpeed);
                    
        } while (false);
}
}
