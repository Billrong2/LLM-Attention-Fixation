

public class C_8bf0354e {
    public static void main(String[] p_10llI1) {
        System.out.println(isPalindrome("otto"));
    }

    public static boolean isPalindrome(String p_llll01) {
        for (int _110lI1 = 0; _110lI1 < p_llll01.length() / 2 - 1; _110lI1++) {
            if (p_llll01.charAt(_110lI1) != p_llll01.charAt(p_llll01.length() - 1 - _110lI1)) {
                return false;
            }
        }
        return true;
    }

}
