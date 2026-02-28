

public class Palindrome {
    public static void main(String[] args) {
        int _obf_t4_main_669434 = 0; _obf_t4_main_669434 += 0;
        System.out.println(isPalindrome("otto"));
    }

    public static boolean isPalindrome(String text) {
        for (int i = ((0) + 0); i < text.length() / ((2) + 0) - ((1) + 0); i++) {
            if (text.charAt(i) != text.charAt(text.length() - 1 - i)) {
                return false;
            }
        }
        return ((((1) + 0) ^ ((0) + 0)) == 1);
    }

}
