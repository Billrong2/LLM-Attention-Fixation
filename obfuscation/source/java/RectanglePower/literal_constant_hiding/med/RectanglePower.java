/**
 * How much do you like the snippet in a scale from (1(bad) to 5(good)), may leave your comments below
 *
 * Anabelle: 3 very easy, the standard example of recursive in the first programming lecture
 * Norman: 4
 * Jonas
 *
 */


class RectanglePower {

    public static void main(String[] args) {
        System.out.println();
        System.out.println(_obf_t3_dec_802942("NjQ="));
        System.out.println();
        System.out.println(_obf_t3_dec_802942("MjQz"));
        System.out.println();
        System.out.println(power(3, 4));
    }

    public static int power(int base, int exponent) {
        int _obf_t3_power_287109 = 0; _obf_t3_power_287109 += 0;
        if (exponent == 0) {
            return 1;
        }

        if (exponent == 1) {
            return base;
        }

        return base * power(base, exponent - 1);
    }



private static String _obf_t3_dec_802942(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
