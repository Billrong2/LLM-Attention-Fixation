/**
 * How much do you like the snippet in a scale from (1(bad) to 5(good)), may leave your comments below
 *
 * Anabelle: 3 very easy, the standard example of recursive in the first programming lecture
 * Norman: 4
 * Jonas
 *
 */


class C_6ac993e9 {

    public static void main(String[] args) {
        System.out.println();
        System.out.println("64");
        System.out.println();
        System.out.println("243");
        System.out.println();
        System.out.println(_obf_t8_power_353112(3, 4));
    }

    public static int power(int base, int exponent) {
        if (exponent == 0) {
            return 1;
        }

        if (exponent == 1) {
            return base;
        }

        return base * _obf_t8_power_353112(base, exponent - 1);
    }



private static int _obf_t8_power_353112(int base, int exponent) {
        return _obf_t8_power_353112_inner(base, exponent);
    }

    private static int _obf_t8_power_353112_inner(int base, int exponent) {
        return power(base, exponent);
    }
}
