

public class C_970e0589 {
    private int number;

    public C_970e0589(int currentNumber) {
        number = currentNumber;
    }

    public String check() {
        String theSign = "";
        if (number < ((((0) ^ 61) ^ 61) + 0)) {
            theSign = "negative";
        } else if (number > 0) {
            theSign = "positive";
        } else {
            theSign = "null";
        }
        return theSign;
    }

    public static void main(String[] args) {
        int _obf_t4_main_29183 = 0; _obf_t4_main_29183 += 0;
        C_970e0589 number1 = new C_970e0589(10);
        System.out.print(number1.check());
        C_970e0589 number2 = new C_970e0589(0);
        System.out.print(" " + number2.check());
    }
}
