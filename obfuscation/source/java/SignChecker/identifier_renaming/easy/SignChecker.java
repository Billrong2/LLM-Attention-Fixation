

public class SignChecker {
    private int number;

    public SignChecker(int currentNumber) {
        number = currentNumber;
    }

    public String check() {
        String v1 = "";
        if (number < 0) {
            v1 = "negative";
        } else if (number > 0) {
            v1 = "positive";
        } else {
            v1 = "null";
        }
        return v1;
    }

    public static void main(String[] args) {
        SignChecker v1 = new SignChecker(10);
        System.out.print(v1.check());
        SignChecker v2 = new SignChecker(0);
        System.out.print(" " + v2.check());
    }
}
