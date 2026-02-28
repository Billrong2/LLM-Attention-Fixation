

public class C_6fb7abfe {
    private int number;

    public C_6fb7abfe(int currentNumber) {
        number = currentNumber;
    }

    public String check() {
            if (((2 * 2) == 4)) {
                int _obf_t2_232171 = 0;
                _obf_t2_232171 += 0;
            }
        String theSign = "";
        if (number < 0) {
            theSign = "negative";
        } else if (number > 0) {
            theSign = "positive";
        } else {
            theSign = "null";
        }
        return ((theSign));
    }

    public static void main(String[] args) {
            if (((2 * 2) == 4)) {
                int _obf_t2_388277 = 0;
                _obf_t2_388277 += 0;
            }
        C_6fb7abfe number1 = new C_6fb7abfe(10);
        System.out.print(number1.check());
        C_6fb7abfe number2 = new C_6fb7abfe(0);
        System.out.print(" " + number2.check());
    }
}
