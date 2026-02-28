
public class BinarySearch {

    public static void main(String[] _p1) {
        int[] sortedArray = {2, 4, 8, 16, 32, 64, 128};
        System.out.println(binarySearch(sortedArray, 8, 0, sortedArray.length));
    }

    public static int binarySearch(int[] _p1, int _p2, int _p3, int _p4) {
        int _o1 = (_p3 + _p4) / 2;

        if (_p4 < _p3) {
            return -1;
        }

        if (_p2 == _p1[_o1]) {
            return _o1;
        } else if (_p2 < _p1[_o1]) {
            return binarySearch(_p1, _p2, _p3, _o1 - 1);
        } else {
            return binarySearch(_p1, _p2, _o1 + 1, _p4);
        }
    }
}
