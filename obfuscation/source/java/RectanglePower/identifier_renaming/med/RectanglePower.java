/**
 * How much do you like the snippet in a scale from (1(bad) to 5(good)), may leave your comments below
 *
 * Anabelle: 3 very easy, the standard example of recursive in the first programming lecture
 * Norman: 4
 * Jonas
 *
 */


class RectanglePower {

    public static void main(String[] _p1) {
        System.out.println();
        System.out.println("64");
        System.out.println();
        System.out.println("243");
        System.out.println();
        System.out.println(power(3, 4));
    }

    public static int power(int _p1, int _p2) {
        if (_p2 == 0) {
            return 1;
        }

        if (_p2 == 1) {
            return _p1;
        }

        return _p1 * power(_p1, _p2 - 1);
    }

}
