

public class Palindrome {
    public static void main(String[] args) {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_main_819041 = 0;
            _obf_t5_main_819041++;
        }
        if (((2 * 2) + 1) > 0) {
            int _obf_t5_main_819041_m = 0;
            _obf_t5_main_819041_m += 0;
        } else {
            int _obf_t5_main_819041_e = 1;
            _obf_t5_main_819041_e -= 1;
        }
        System.out.println(isPalindrome("otto"));
    }

    public static boolean isPalindrome(String text) {
        int _obf_t5_isPalindrome_542655 = 0; _obf_t5_isPalindrome_542655 += 0;
        for (int i = 0; i < text.length() / 2 - 1; i++) {
            if (text.charAt(i) != text.charAt(text.length() - 1 - i)) {
                return false;
            }
        }
        return true;
    }

}
