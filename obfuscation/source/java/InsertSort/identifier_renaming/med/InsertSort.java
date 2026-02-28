
public class InsertSort {

    public static void main(String[] _p1) {
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

    public static int[] sort(int[] _p1) {
        for (int _o1 = 1; _o1 < _p1.length; _o1++) {
            for (int _o2 = _o1; _o2 > 0; _o2--) {
                int _o3 = _p1[_o2];
                int _o4 = _p1[_o2 - 1];
                if (_o3 < _o4) {
                    _p1[_o2 - 1] = _o3;
                    _p1[_o2] = _o4;
                } else {
                    break;
                }
            }
        }
        return _p1;
    }

}
