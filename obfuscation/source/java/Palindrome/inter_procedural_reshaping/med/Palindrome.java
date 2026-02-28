

public class Palindrome {
    public static void main(String[] args) {
        _obf_t7_hook_main_890447();
        System.out.println(isPalindrome("otto"));
    }

    public static boolean isPalindrome(String text) {
        _obf_t7_hook_isPalindrome_342093();
        for (int i = 0; i < text.length() / 2 - 1; i++) {
            if (text.charAt(i) != text.charAt(text.length() - 1 - i)) {
                return false;
            }
        }
        return true;
    }



private static void _obf_t7_hook_isPalindrome_342093() {
        int _obf_t7_342093 = 0;
        _obf_t7_342093 += 0;
    }

    private static void _obf_t7_hook_main_890447() {
        int _obf_t7_890447 = 0;
        _obf_t7_890447 += 0;
    }
}
