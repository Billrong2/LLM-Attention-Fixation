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
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_main_412251 = 0;
            _obf_t5_main_412251++;
        }
        if (((2 * 2) + 1) > 0) {
            int _obf_t5_main_412251_m = 0;
            _obf_t5_main_412251_m += 0;
        } else {
            int _obf_t5_main_412251_e = 1;
            _obf_t5_main_412251_e -= 1;
        }
        System.out.println();
        System.out.println("64");
        System.out.println();
        System.out.println("243");
        System.out.println();
        System.out.println(power(3, 4));
    }

    public static int power(int base, int exponent) {
        int _obf_t5_power_606761 = 0; _obf_t5_power_606761 += 0;
        if (exponent == 0) {
            return 1;
        }

        if (exponent == 1) {
            return base;
        }

        return base * power(base, exponent - 1);
    }

}
