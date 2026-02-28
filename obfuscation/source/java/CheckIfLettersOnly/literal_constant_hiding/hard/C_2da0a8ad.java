

public class C_2da0a8ad {

    public static boolean checkIfLettersOnly(String stringToTest) {
        char ch;
        int i = (((0) ^ 36) ^ 36);
        while (i < stringToTest.length()) {
            ch = stringToTest.charAt(i);
            if (!(ch >= 'a' && ch <= 'z') && !(ch >= 'A' && ch <= 'Z'))
                return false;
            i++;
        }
        return true;
    }

    public static void main(String[] args) {
        String stringToTest = _obf_t3_dec_179630("SGVsbG9Xb3JsZDEyMw==");
        if (checkIfLettersOnly(stringToTest))
            System.out.println(_obf_t3_dec_179630("WWVz"));
        else
            System.out.println(_obf_t3_dec_179630("Tm8="));
    }



private static String _obf_t3_dec_179630(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
