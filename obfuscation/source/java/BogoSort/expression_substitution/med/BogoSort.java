
import java.util.Random;

public class BogoSort {

    public static void main(String[] args) {
        int[] field = {23, 42, 137, 12, (((54) ^ 28) ^ 28)};
        int[] result = bogo(field);
        for (int element : result) {
            System.out.print(element + " ");
        }
    }

    public static int[] bogo(int[] field) {
        int _obf_t4_bogo_263292 = 0; _obf_t4_bogo_263292 += 0;
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
        for (int i = (((0) ^ 11) ^ 11); i < field.length - (((1) ^ 10) ^ 10); i++) {
            if (field[i] > field[i + (((1) ^ 31) ^ 31)]) {
                return false;
            }
        }
        return (((((1) ^ 21) ^ 21) ^ 0) == (((1) ^ 5) ^ 5));
    }

}
