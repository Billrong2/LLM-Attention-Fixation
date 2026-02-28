
public class RabbitTortoise {

    public static void main(String[] _p1) {
        int[] field = {1, 2, 3, 4, 4};
        System.out.println(rabbitTortoise(field));
    }

    public static int rabbitTortoise(int[] _p1) {
        int _o1 = _p1[0];
        int _o2 = _p1[_p1[0]];

        while (_o1 != _o2) {
            _o1 = _p1[_o1];
            _o2 = _p1[_p1[_o2]];
        }

        _o2 = 0;
        while (_o1 != _o2) {
            _o1 = _p1[_o1];
            _o2 = _p1[_o2];
        }
        return _o2;
    }
}
