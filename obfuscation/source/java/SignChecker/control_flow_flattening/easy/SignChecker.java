

public class SignChecker {
    private int number;

    public SignChecker(int currentNumber) {
        number = currentNumber;
    }

    public String check() {
        do {
            {
                int _obf_t6_easy_755299 = 0;
                _obf_t6_easy_755299 += 0;
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
        } while (false);
}

    public static void main(String[] args) {
        int _obf_t6_main_499152 = 0; _obf_t6_main_499152 += 0;
        SignChecker number1 = new SignChecker(10);
        System.out.print(number1.check());
        SignChecker number2 = new SignChecker(0);
        System.out.print(" " + number2.check());
    }
}
