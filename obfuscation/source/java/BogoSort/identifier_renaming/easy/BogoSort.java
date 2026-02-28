
import java.util.Random;

public class BogoSort {

    public static void main(String[] args) {
        int _obf_t1_main_584065 = 0; _obf_t1_main_584065 += 0;
        int[] field = {23, 42, 137, 12, 54};
        int[] result = bogo(field);
        for (int element : result) {
            System.out.print(element + " ");
        }
    }

    public static int[] bogo(int[] field) {
        Random v1 = new Random();

        while (!isFinished(field)) {
            int v2 = v1.nextInt(field.length);
            int v3 = v1.nextInt(field.length);

            int v4 = field[v2];
            field[v2] = field[v3];
            field[v3] = v4;
        }

        return field;
    }

    public static boolean isFinished(int[] field) {
        for (int v1 = 0; v1 < field.length - 1; v1++) {
            if (field[v1] > field[v1 + 1]) {
                return false;
            }
        }
        return true;
    }

}
