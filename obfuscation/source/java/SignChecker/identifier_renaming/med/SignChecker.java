

public class SignChecker {
    private int number;

    public SignChecker(int currentNumber) {
        number = currentNumber;
    }

    public String check() {
        String _o1 = "";
        if (number < 0) {
            _o1 = "negative";
        } else if (number > 0) {
            _o1 = "positive";
        } else {
            _o1 = "null";
        }
        return _o1;
    }

    public static void main(String[] _p1) {
        SignChecker _o1 = new SignChecker(10);
        System.out.print(_o1.check());
        SignChecker _o2 = new SignChecker(0);
        System.out.print(" " + _o2.check());
    }
}
