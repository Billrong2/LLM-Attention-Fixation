

public class Palindrome {
    public static void main(String[] args) {
        int _obf_t1_main_888365 = 0; _obf_t1_main_888365 += 0;
        System.out.println(isPalindrome("otto"));
    }

    public static boolean isPalindrome(String text) {
        for (int v1 = 0; v1 < text.length() / 2 - 1; v1++) {
            if (text.charAt(v1) != text.charAt(text.length() - 1 - v1)) {
                return false;
            }
        }
        return true;
    }

}
