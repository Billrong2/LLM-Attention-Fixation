
public class BinToDecimal {

    public static void main(String[] _p1) {
        String _o1 = "1001";
        int _o2 = 1;
        System.out.println();
        System.out.println("9");
        System.out.println();
        System.out.println("4");
        System.out.println();
        System.out.println(binaryToDecimal(_o1, _o2));
    }

    static int binaryToDecimal(String _p1, int _p2) {
        if (_p2 < 0) {
            return 0;
        } else if (_p1.charAt(_p2) == '0') {
            return 2 * binaryToDecimal(_p1, _p2 - 1);
        }

        return 1 + 2 * binaryToDecimal(_p1, _p2 - 1);
    }

}
