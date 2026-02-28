

public class C_38042356 {
    private int number;

    public C_38042356(int currentNumber) {
        number = currentNumber;
    }

    public String check() {
        int _obf_t6_state_check_755299 = 0;
        while (_obf_t6_state_check_755299 == 0) {
            _obf_t6_state_check_755299 = 1;
            break;
        }
        if ((_obf_t6_state_check_755299 ^ 1) < 0) {
            int _obf_t6_guard_755299 = 0;
            _obf_t6_guard_755299 += 0;
        }
        do {
                    String theSign = "";
                    if (number < 0) {
                    theSign = "negative";
                    } else if (number > 0) {
                    theSign = "positive";
                    } else {
                    theSign = "null";
                    }
                    return theSign;
                    
        } while (false);
}

    public static void main(String[] args) {
        int _obf_t6_main_499152 = 0; _obf_t6_main_499152 += 0;
        C_38042356 number1 = new C_38042356(10);
        System.out.print(number1.check());
        C_38042356 number2 = new C_38042356(0);
        System.out.print(" " + number2.check());
    }
}
