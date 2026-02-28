

public class SignChecker {
    private int number;

    public SignChecker(int currentNumber) {
        number = currentNumber;
    }

    public String check() {
        String theSign = _obf_t3_dec_348411("");
        if (number < 0) {
            theSign = _obf_t3_dec_348411("bmVnYXRpdmU=");
        } else if (number > 0) {
            theSign = _obf_t3_dec_348411("cG9zaXRpdmU=");
        } else {
            theSign = _obf_t3_dec_348411("bnVsbA==");
        }
        return theSign;
    }

    public static void main(String[] args) {
        SignChecker number1 = new SignChecker(10);
        System.out.print(number1.check());
        SignChecker number2 = new SignChecker(0);
        System.out.print(_obf_t3_dec_348411("IA==") + number2.check());
    }


private static String _obf_t3_dec_348411(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
