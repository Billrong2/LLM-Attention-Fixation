

public class Palindrome {
    public static void main(String[] args) {
        System.out.println(isPalindrome(("" + "otto")));
    }

    public static boolean isPalindrome(String text) {
        int _obf_t3_isPalindrome_246960 = 0; _obf_t3_isPalindrome_246960 += 0;
        for (int i = 0; i < text.length() / 2 - 1; i++) {
            if (text.charAt(i) != text.charAt(text.length() - 1 - i)) {
                return false;
            }
        }
        return true;
    }

}
