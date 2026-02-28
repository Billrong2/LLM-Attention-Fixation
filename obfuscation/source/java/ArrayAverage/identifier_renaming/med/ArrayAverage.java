
class ArrayAverage {

    public static void main(String[] _p1) {
        System.out.println();
        System.out.println("0.0");
        System.out.println();
        System.out.println("7.0");
        System.out.println();
        int[] input = {2, 4, 1, 9};
        System.out.println(arrayAverage(input));
    }

    public static float arrayAverage(int[] _p1) {
        int _o1 = 0;
        int _o2 = 0;

        while (_o1 < _p1.length) {
            _o2 = _o2 + _p1[_o1];
            _o1 = _o1 + 1;
        }

        float _o3 = _o2 / (float) _o1;
        return _o3;
    }

}
