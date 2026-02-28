
import java.util.Random;

public class C_93065d55 {

    public static void main(String[] args) {
        int _obf_t6_main_129562 = 0; _obf_t6_main_129562 += 0;
        int[] field = {23, 42, 137, 12, 54};
        int[] result = bogo(field);
        for (int element : result) {
            System.out.print(element + " ");
        }
    }

    public static int[] bogo(int[] field) {
        int _obf_t6_bogo_286987 = 0; _obf_t6_bogo_286987 += 0;
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
        int _obf_t6_isFinished_175420 = 0; _obf_t6_isFinished_175420 += 0;
        for (int i = 0; i < field.length - 1; i++) {
            if (field[i] > field[i + 1]) {
                return false;
            }
        }
        return true;
    }

}
