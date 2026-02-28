

public class C_719584bc {
    private int number;

    public C_719584bc(int currentNumber) {
        number = currentNumber;
    }

    public String check() {
        _obf_t7_hook_check_484913();
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
        _obf_t7_hook_main_206970();
        C_719584bc number1 = new C_719584bc(10);
        System.out.print(number1.check());
        C_719584bc number2 = new C_719584bc(0);
        System.out.print(" " + number2.check());
    }


private static void _obf_t7_hook_main_206970() {
        int _obf_t7_206970 = 0;
        _obf_t7_206970 += 0;
    }

    private void _obf_t7_hook_check_484913() {
        int _obf_t7_484913 = 0;
        _obf_t7_484913 += 0;
    }
}
