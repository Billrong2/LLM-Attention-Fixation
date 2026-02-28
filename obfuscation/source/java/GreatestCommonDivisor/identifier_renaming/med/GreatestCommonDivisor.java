
class GreatestCommonDivisor {

    public static void main(String[] _p1) {
        System.out.println();
        System.out.println("15");
        System.out.println();
        System.out.println("1");
        System.out.println();
        int _o1 = 20;
        int _o2 = 15;
        System.out.println(greatestCommonDivisor(_o1, _o2));
    }

    public static int greatestCommonDivisor(int _p1, int _p2) {
        int _o1 = _p1;

        while (_o1 != 0) {
            if (_p1 < _p2) {
                _o1 = _p1;
                _p1 = _p2;
                _p2 = _o1;
            }
            _o1 = _p1 % _p2;
            if (_o1 != 0) {
                _p1 = _p2;
                _p2 = _o1;
            }
        }

        return _p2;
    }

}
