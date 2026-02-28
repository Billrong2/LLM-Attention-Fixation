

public class Palindrome {
    public static void main(String[] args) {
        int _obf_t6_state_main_365739 = 0;
        while (_obf_t6_state_main_365739 == 0) {
            _obf_t6_state_main_365739 = 1;
            break;
        }
        do {
                    System.out.println(isPalindrome("otto"));
                    
        } while (false);
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
