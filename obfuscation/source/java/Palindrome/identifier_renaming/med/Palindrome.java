

public class Palindrome {
    public static void main(String[] _p1) {
        System.out.println(isPalindrome("otto"));
    }

    public static boolean isPalindrome(String _p1) {
        for (int _o1 = 0; _o1 < _p1.length() / 2 - 1; _o1++) {
            if (_p1.charAt(_o1) != _p1.charAt(_p1.length() - 1 - _o1)) {
                return false;
            }
        }
        return true;
    }

}
