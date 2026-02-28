

public class C_42ed1edc {
    public static void main(String[] args) {
        System.out.println(isPalindrome(_obf_t3_dec_346148("b3R0bw==")));
    }

    public static boolean isPalindrome(String text) {
        for (int i = (((0) ^ 23) ^ 23); i < text.length() / (((2) ^ 4) ^ 4) - (((1) ^ 23) ^ 23); i++) {
            if (text.charAt(i) != text.charAt(text.length() - (((1) ^ 46) ^ 46) - i)) {
                return false;
            }
        }
        return true;
    }



private static String _obf_t3_dec_346148(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
