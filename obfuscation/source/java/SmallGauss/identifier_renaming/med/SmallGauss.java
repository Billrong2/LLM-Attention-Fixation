
class SmallGauss {

    public static void main(String[] _p1) {
        System.out.println(sum(10));
    }

    public static int sum(int _p1) {
        int _o1 = 0;
        for (int _o2 = 1; _o2 < _p1; _o2++) {
            _o1 += _o2;
        }
        return _o1;
    }
}
