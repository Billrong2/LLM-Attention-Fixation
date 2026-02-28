
public class BinomialCoefficient {

    public static void main(String[] _p1) {
        int _o1 = 3;
        int _o2 = 2;
        int _o3 = binomialCoefficient(_o1, _o2);
        System.out.println(_o3);
    }

    public static int binomialCoefficient(int _p1, int _p2) {
        int _o1 = 1;

        if (_p2 > _p1 - _p2)
            _p2 = _p1 - _p2;

        for (int _o2 = 0; _o2 < _p2; ++_o2) {
            _o1 *= (_p1 - _o2);
            _o1 /= (_o2 + 1);
        }
        return _o1;
    }
}
