
public class MedianOnSorted {
    public static void main(String[] _p1) {
        int[] array = {1, 2, 4, 5, 6, 16};

        System.out.println(median(array));
    }

    public static float median(int[] _p1) {
        float _o1;
        if (_p1.length % 2 == 1)
            _o1 = _p1[_p1.length / 2];
        else
            _o1 = (_p1[_p1.length / 2 - 1] + _p1[_p1.length / 2]) / 2f;
        return _o1;
    }
}
