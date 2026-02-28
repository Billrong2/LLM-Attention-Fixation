

public class C_ac6fd1e2 {
    private int number;

    public C_ac6fd1e2(int currentNumber) {
        number = currentNumber;
    }

    public String check() {
        String theSign = _obf_t3_dec_348411("");
        if (number < (((0) ^ 36) ^ 36)) {
            theSign = _obf_t3_dec_348411("bmVnYXRpdmU=");
        } else if (number > (((0) ^ 52) ^ 52)) {
            theSign = _obf_t3_dec_348411("cG9zaXRpdmU=");
        } else {
            theSign = _obf_t3_dec_348411("bnVsbA==");
        }
        return theSign;
    }

    public static void main(String[] args) {
        C_ac6fd1e2 number1 = new C_ac6fd1e2((((10) ^ 53) ^ 53));
        System.out.print(number1.check());
        C_ac6fd1e2 number2 = new C_ac6fd1e2((((0) ^ 11) ^ 11));
        System.out.print(_obf_t3_dec_348411("IA==") + number2.check());
    }


private static String _obf_t3_dec_348411(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
