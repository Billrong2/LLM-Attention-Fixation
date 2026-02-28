/**
 * How much do you like the snippet in a scale from (1(bad) to 5(good)), may leave your comments below
 *
 * Anabelle: 3 very easy, the standard example of recursive in the first programming lecture
 * Norman: 4
 * Jonas
 *
 */


class C_ab2f296c {

    public static void main(String[] p_l1IlO1) {
        System.out.println();
        System.out.println("64");
        System.out.println();
        System.out.println("243");
        System.out.println();
        System.out.println(power(3, 4));
    }

    public static int power(int p_IO1011, int p_1I1I12) {
        if (p_1I1I12 == 0) {
            return 1;
        }

        if (p_1I1I12 == 1) {
            return p_IO1011;
        }

        return p_IO1011 * power(p_IO1011, p_1I1I12 - 1);
    }

}
