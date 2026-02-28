
public class C_ac3a3a21 {

    public static void main(String[] p_lI10l1) {
        System.out.println();
        System.out.println("7 5 4 3");
        System.out.println();
        System.out.println("5 4 7 3");
        System.out.println();
        int[] unsorted = {3, 7, 4, 5};
        int[] result = sort(unsorted);
        for (int j : result) {
            System.out.print("" + j + " ");
        }
    }

    public static int[] sort(int[] p_0I0lI1) {
        for (int _Ol1I11 = 1; _Ol1I11 < p_0I0lI1.length; _Ol1I11++) {
            for (int _OO11l2 = _Ol1I11; _OO11l2 > 0; _OO11l2--) {
                int _O010l3 = p_0I0lI1[_OO11l2];
                int _I0II14 = p_0I0lI1[_OO11l2 - 1];
                if (_O010l3 < _I0II14) {
                    p_0I0lI1[_OO11l2 - 1] = _O010l3;
                    p_0I0lI1[_OO11l2] = _I0II14;
                } else {
                    break;
                }
            }
        }
        return p_0I0lI1;
    }

}
