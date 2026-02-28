
class ReverseArray {
    public static void main(String[] _p1) {
        int[] array = {1, 6, 4, 16, 2};
        reverse(array);

        for (int i : array)
            System.out.print(i + " ");
    }

    public static void reverse(int[] _p1) {
        for (int _o1 = 0; _o1 <= _p1.length / 2 - 1; _o1++) {
            int _o2 = _p1[_p1.length - 1 - _o1];
            _p1[_p1.length - _o1 - 1] = _p1[_o1];
            _p1[_o1] = _o2;
        }
    }
}
