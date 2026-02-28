

public class Palindrome {
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
        int _obf_sel = 3;
        switch (_obf_sel) {
            case 3: return isPalindrome(text);
            default: return isPalindrome(text);
        }
    }
}
