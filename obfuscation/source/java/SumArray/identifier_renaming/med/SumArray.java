
public class SumArray {

    public static void main(String[] _p1) {
        int[] array = {1, 6, 4, 10, 2};
        System.out.println(sumArray(array));
    }

    public static int sumArray(int[] _p1) {
        int _o1 = 0;

        for (int _o2 = 0; _o2 < _p1.length; _o2++) {
            _o1 = _o1 + _p1[_o2];
        }

        return _o1;
    }
}
