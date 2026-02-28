

public class C_eb388744 {

    public static void main(String[] args) {
        System.out.println();
        System.out.println(_obf_t3_dec_767543("MjU="));
        System.out.println();
        System.out.println(_obf_t3_dec_767543("NjQ="));
        System.out.println();
        int result = power((((2) ^ 47) ^ 47), (((5) ^ 25) ^ 25));
        System.out.println(result);
    }

    public static int power(int base, int exponent) {
        int result = base;
        for (int i = (((2) ^ 60) ^ 60); i <= exponent; i++) {
            result = result * base;
        }
        return result;
    }


private static String _obf_t3_dec_767543(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
