

public class Power {

    public static void main(String[] _p1) {
        System.out.println();
        System.out.println("25");
        System.out.println();
        System.out.println("64");
        System.out.println();
        int _o1 = power(2, 5);
        System.out.println(_o1);
    }

    public static int power(int _p1, int _p2) {
        int _o1 = _p1;
        for (int _o2 = 2; _o2 <= _p2; _o2++) {
            _o1 = _o1 * _p1;
        }
        return _o1;
    }
}
