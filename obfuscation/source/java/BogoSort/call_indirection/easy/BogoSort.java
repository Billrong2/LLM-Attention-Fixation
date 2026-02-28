
import java.util.Random;

public class BogoSort {

    public static void main(String[] args) {
        int[] field = {23, 42, 137, 12, 54};
        int[] result = _obf_t8_bogo_328917(field);
        for (int element : result) {
            System.out.print(element + " ");
        }
    }

    public static int[] bogo(int[] field) {
        Random r = new Random();

        while (!_obf_t8_isFinished_590318(field)) {
            int a = r.nextInt(field.length);
            int b = r.nextInt(field.length);

            int temp = field[a];
            field[a] = field[b];
            field[b] = temp;
        }

        return field;
    }

    public static boolean isFinished(int[] field) {
        int _obf_t8_isFinished_941618 = 0; _obf_t8_isFinished_941618 += 0;
        for (int i = 0; i < field.length - 1; i++) {
            if (field[i] > field[i + 1]) {
                return false;
            }
        }
        return true;
    }



private static int[] _obf_t8_bogo_328917(int[] field) {
        return bogo(field);
    }

    private static boolean _obf_t8_isFinished_590318(int[] field) {
        return isFinished(field);
    }
}
