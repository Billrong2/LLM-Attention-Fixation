/**
 * How much do you like the snippet in a scale from (1(bad) to 5(good)), may leave your comments below
 *
 * Anabelle: 3 very easy, the standard example of recursive in the first programming lecture
 * Norman: 4
 * Jonas
 *
 */


class C_7646675d {

    public static void main(String[] args) {
        System.out.println();
        System.out.println(_obf_t3_dec_802942("NjQ="));
        System.out.println();
        System.out.println(_obf_t3_dec_802942("MjQz"));
        System.out.println();
        System.out.println(power((((3) ^ 15) ^ 15), (((4) ^ 56) ^ 56)));
    }

    public static int power(int base, int exponent) {
        if (exponent == (((0) ^ 40) ^ 40)) {
            return (((1) ^ 31) ^ 31);
        }

        if (exponent == (((1) ^ 7) ^ 7)) {
            return base;
        }

        return base * power(base, exponent - (((1) ^ 50) ^ 50));
    }



private static String _obf_t3_dec_802942(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
