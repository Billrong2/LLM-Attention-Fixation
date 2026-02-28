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
        do {
            {
                int _obf_t6_easy_562964 = 0;
                _obf_t6_easy_562964 += 0;
                    System.out.println();
                    System.out.println("64");
                    System.out.println();
                    System.out.println("243");
                    System.out.println();
                    System.out.println(power(3, 4));
                    
            }
        } while (false);
}

    public static int power(int base, int exponent) {
        do {
            {
                int _obf_t6_easy_730668 = 0;
                _obf_t6_easy_730668 += 0;
                    if (exponent == 0) {
                    return 1;
                    }
                    
                    if (exponent == 1) {
                    return base;
                    }
                    
                    return base * power(base, exponent - 1);
                    
            }
        } while (false);
}

}
