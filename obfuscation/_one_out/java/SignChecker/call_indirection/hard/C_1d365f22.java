

public class C_1d365f22 {
    private int number;

    public C_1d365f22(int currentNumber) {
        number = currentNumber;
    }

    public String check() {
        int _obf_t8_check_322609 = 0; _obf_t8_check_322609 += 0;
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
        int _obf_t8_main_475211 = 0; _obf_t8_main_475211 += 0;
        C_1d365f22 number1 = new C_1d365f22(10);
        System.out.print(number1.check());
        C_1d365f22 number2 = new C_1d365f22(0);
        System.out.print(" " + number2.check());
    }
}
