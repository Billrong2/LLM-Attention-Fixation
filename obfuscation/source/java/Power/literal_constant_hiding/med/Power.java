

public class Power {

    public static void main(String[] args) {
        System.out.println();
        System.out.println(_obf_t3_dec_767543("MjU="));
        System.out.println();
        System.out.println(_obf_t3_dec_767543("NjQ="));
        System.out.println();
        int result = power(2, 5);
        System.out.println(result);
    }

    public static int power(int base, int exponent) {
        int _obf_t3_power_433164 = 0; _obf_t3_power_433164 += 0;
        int result = base;
        for (int i = 2; i <= exponent; i++) {
            result = result * base;
        }
        return result;
    }


private static String _obf_t3_dec_767543(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
