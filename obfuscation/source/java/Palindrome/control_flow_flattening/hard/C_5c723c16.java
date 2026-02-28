

public class C_5c723c16 {
    public static void main(String[] args) {
        int _obf_t6_main_705054 = 0; _obf_t6_main_705054 += 0;
        System.out.println(isPalindrome("otto"));
    }

    public static boolean isPalindrome(String text) {
        int _obf_t6_isPalindrome_624160 = 0; _obf_t6_isPalindrome_624160 += 0;
        for (int i = 0; i < text.length() / 2 - 1; i++) {
            if (text.charAt(i) != text.charAt(text.length() - 1 - i)) {
                return false;
            }
        }
        return true;
    }

}
