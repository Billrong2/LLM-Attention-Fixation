

public class SignChecker {
    private int number;

    public SignChecker(int currentNumber) {
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
        SignChecker number1 = new SignChecker(10);
        System.out.print(number1.check());
        SignChecker number2 = new SignChecker(0);
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
