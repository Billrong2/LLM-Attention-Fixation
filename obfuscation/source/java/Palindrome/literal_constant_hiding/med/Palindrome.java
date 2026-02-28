

public class Palindrome {
    public static void main(String[] args) {
        System.out.println(isPalindrome(_obf_t3_dec_346148("b3R0bw==")));
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



private static String _obf_t3_dec_346148(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
