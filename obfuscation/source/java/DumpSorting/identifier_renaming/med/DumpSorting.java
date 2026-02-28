
import java.util.Arrays;
import java.util.List;

class DumpSorting {

    public static void main(String[] _p1) {
        System.out.println();
        System.out.println("[12, 11, 9, 8]");
        System.out.println();
        System.out.println("[11, 9, 12, 8]");
        System.out.println();
        int _o1 = 9;
        int _o2 = 12;
        int _o3 = 8;
        int _o4 = 11;
        System.out.println(sort(_o1, _o2, _o3, _o4));
    }

    public static List<Integer> sort(int _p1, int _p2, int _p3, int _p4) {
        if (_p1 > _p2) {
            int _o1 = _p2;
            _p2 = _p1;
            _p1 = _o1;
        }
        if (_p3 > _p4) {
            int _o1 = _p4;
            _p4 = _p3;
            _p3 = _o1;
        }
        if (_p1 > _p3) {
            int _o1 = _p3;
            _p3 = _p1;
            _p1 = _o1;
        }
        if (_p2 > _p4) {
            int _o1 = _p4;
            _p4 = _p2;
            _p2 = _o1;
        }
        if (_p2 > _p3) {
            int _o1 = _p3;
            _p3 = _p2;
            _p2 = _o1;
        }

        return Arrays.asList(_p1, _p2, _p3, _p4);
    }

}
