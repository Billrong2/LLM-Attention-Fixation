
public class C_79b24cd1 {

    public static void main(String[] p_OOIIl1) {
        String _1IIlO1 = "1001";
        int _0OOlO2 = 1;
        System.out.println();
        System.out.println("9");
        System.out.println();
        System.out.println("4");
        System.out.println();
        System.out.println(binaryToDecimal(_1IIlO1, _0OOlO2));
    }

    static int binaryToDecimal(String p_IOlOO1, int p_I00O02) {
        if (p_I00O02 < 0) {
            return 0;
        } else if (p_IOlOO1.charAt(p_I00O02) == '0') {
            return 2 * binaryToDecimal(p_IOlOO1, p_I00O02 - 1);
        }

        return 1 + 2 * binaryToDecimal(p_IOlOO1, p_I00O02 - 1);
    }

}
