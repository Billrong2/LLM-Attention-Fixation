

public class C_67d2a250 {
    public static void main(String[] args) {
        System.out.println(_obf_t8_isPalindrome_255468("otto"));
    }

    public static boolean isPalindrome(String text) {
        int _obf_t8_isPalindrome_184419 = 0; _obf_t8_isPalindrome_184419 += 0;
        for (int i = 0; i < text.length() / 2 - 1; i++) {
            if (text.charAt(i) != text.charAt(text.length() - 1 - i)) {
                return false;
            }
        }
        return true;
    }



private static boolean _obf_t8_isPalindrome_255468(String text) {
        return _obf_t8_isPalindrome_255468_inner(text);
    }

    private static boolean _obf_t8_isPalindrome_255468_inner(String text) {
        return isPalindrome(text);
    }
}
