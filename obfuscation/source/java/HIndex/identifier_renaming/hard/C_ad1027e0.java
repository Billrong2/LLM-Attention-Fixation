

import java.util.Arrays;

public class C_ad1027e0 {

    public static void main(String[] p_ll11l1) {
        System.out.println();
        System.out.println("1");
        System.out.println();
        System.out.println("9");
        System.out.println();
        int[] numbers = {2, 4, 1, 4, 9};
        System.out.println(hIndex(numbers));
    }

    public static int hIndex(int[] p_lO0O11) {
        Arrays.sort(p_lO0O11);

        int _IllOO1 = p_lO0O11.length;
        int _0IOOl2 = 0;
        for (int _l1I103 = _IllOO1 - 1; _l1I103 >= 0; _l1I103--) {
            int _1l1I04 = _IllOO1 - 1;
            if (p_lO0O11[_l1I103] >= _1l1I04) {
                _0IOOl2 = _1l1I04;
            } else {
                break;
            }
        }
        return _0IOOl2;
    }

}
