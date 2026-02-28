
import java.util.Random;

public class BogoSort {

    public static void main(String[] args) {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_main_42238 = 0;
            _obf_t5_main_42238++;
        }
        int[] field = {23, 42, 137, 12, 54};
        int[] result = bogo(field);
        for (int element : result) {
            System.out.print(element + " ");
        }
    }

    public static int[] bogo(int[] field) {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_bogo_101880 = 0;
            _obf_t5_bogo_101880++;
        }
        Random r = new Random();

        while (!isFinished(field)) {
            int a = r.nextInt(field.length);
            int b = r.nextInt(field.length);

            int temp = field[a];
            field[a] = field[b];
            field[b] = temp;
        }

        return field;
    }

    public static boolean isFinished(int[] field) {
        int _obf_t5_isFinished_118695 = 0; _obf_t5_isFinished_118695 += 0;
        for (int i = 0; i < field.length - 1; i++) {
            if (field[i] > field[i + 1]) {
                return false;
            }
        }
        return true;
    }

}
