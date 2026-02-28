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
        int _obf_t1_main_558220 = 0; _obf_t1_main_558220 += 0;
        System.out.println();
        System.out.println("64");
        System.out.println();
        System.out.println("243");
        System.out.println();
        System.out.println(power(3, 4));
    }

    public static int power(int base, int exponent) {
        int _obf_t1_power_5075 = 0; _obf_t1_power_5075 += 0;
        if (exponent == 0) {
            return 1;
        }

        if (exponent == 1) {
            return base;
        }

        return base * power(base, exponent - 1);
    }

}
