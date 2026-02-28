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
        _obf_t7_hook_main_989370();
        System.out.println();
        System.out.println("64");
        System.out.println();
        System.out.println("243");
        System.out.println();
        System.out.println(power(3, 4));
    }

    public static int power(int base, int exponent) {
        _obf_t7_hook_power_409263();
        if (exponent == 0) {
            return 1;
        }

        if (exponent == 1) {
            return base;
        }

        return base * power(base, exponent - 1);
    }



private static void _obf_t7_hook_power_409263() {
        int _obf_t7_409263 = 0;
        _obf_t7_409263 += 0;
    }

    private static void _obf_t7_hook_main_989370() {
        int _obf_t7_989370 = 0;
        _obf_t7_989370 += 0;
    }
}
