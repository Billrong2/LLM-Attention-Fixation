

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
        do {
            {
                int _obf_t6_easy_158250 = 0;
                _obf_t6_easy_158250 += 0;
                    if ((this.currentSpeed + kmh) > this.topSpeed) {
                    this.currentSpeed = this.topSpeed;
                    } else {
                    this.currentSpeed = this.currentSpeed + kmh;
                    }
                    
            }
        } while (false);
}

    public static void main(String args[]) {
        do {
            {
                int _obf_t6_easy_739637 = 0;
                _obf_t6_easy_739637 += 0;
                    Vehicle v = new Vehicle("Audi", "A6", 200);
                    v.accelerate(10);
                    System.out.println(v.currentSpeed);
                    
            }
        } while (false);
}
}
