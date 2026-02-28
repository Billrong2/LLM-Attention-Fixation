

import java.util.Arrays;

public class HIndex {

    public static void main(String[] _p1) {
        System.out.println();
        System.out.println("1");
        System.out.println();
        System.out.println("9");
        System.out.println();
        int[] numbers = {2, 4, 1, 4, 9};
        System.out.println(hIndex(numbers));
    }

    public static int hIndex(int[] _p1) {
        Arrays.sort(_p1);

        int _o1 = _p1.length;
        int _o2 = 0;
        for (int _o3 = _o1 - 1; _o3 >= 0; _o3--) {
            int _o4 = _o1 - 1;
            if (_p1[_o3] >= _o4) {
                _o2 = _o4;
            } else {
                break;
            }
        }
        return _o2;
    }

}
