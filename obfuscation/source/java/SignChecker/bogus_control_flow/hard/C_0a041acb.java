

public class C_0a041acb {
    private int number;

    public C_0a041acb(int currentNumber) {
        number = currentNumber;
    }

    public String check() {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_check_705132 = 0;
            _obf_t5_check_705132++;
        }
        if (((2 * 2) + 1) > 0) {
            int _obf_t5_check_705132_m = 0;
            _obf_t5_check_705132_m += 0;
        } else {
            int _obf_t5_check_705132_e = 1;
            _obf_t5_check_705132_e -= 1;
        }
        int _obf_t5_check_705132_h = (1 ^ 1);
        if (_obf_t5_check_705132_h != 0) {
            _obf_t5_check_705132_h += 1;
        }
        String theSign = "";
        if (number < 0) {
            theSign = "negative";
        } else if (number > 0) {
            theSign = "positive";
        } else {
            theSign = "null";
        }
        return theSign;
    }

    public static void main(String[] args) {
        int _obf_t5_main_426230 = 0; _obf_t5_main_426230 += 0;
        C_0a041acb number1 = new C_0a041acb(10);
        System.out.print(number1.check());
        C_0a041acb number2 = new C_0a041acb(0);
        System.out.print(" " + number2.check());
    }
}
