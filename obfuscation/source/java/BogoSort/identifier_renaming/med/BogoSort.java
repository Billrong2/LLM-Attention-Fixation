
import java.util.Random;

public class BogoSort {

    public static void main(String[] _p1) {
        int[] field = {23, 42, 137, 12, 54};
        int[] result = bogo(field);
        for (int element : result) {
            System.out.print(element + " ");
        }
    }

    public static int[] bogo(int[] _p1) {
        Random _o1 = new Random();

        while (!isFinished(_p1)) {
            int _o2 = _o1.nextInt(_p1.length);
            int _o3 = _o1.nextInt(_p1.length);

            int _o4 = _p1[_o2];
            _p1[_o2] = _p1[_o3];
            _p1[_o3] = _o4;
        }

        return _p1;
    }

    public static boolean isFinished(int[] _p1) {
        for (int _o1 = 0; _o1 < _p1.length - 1; _o1++) {
            if (_p1[_o1] > _p1[_o1 + 1]) {
                return false;
            }
        }
        return true;
    }

}
