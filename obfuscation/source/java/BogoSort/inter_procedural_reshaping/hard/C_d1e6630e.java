
import java.util.Random;

public class C_d1e6630e {

    public static void main(String[] args) {
        _obf_t7_hook_main_337700();
        int[] field = {23, 42, 137, 12, 54};
        int[] result = bogo(field);
        for (int element : result) {
            System.out.print(element + " ");
        }
    }

    public static int[] bogo(int[] field) {
        _obf_t7_hook_bogo_885407();
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
        _obf_t7_hook_isFinished_61643();
        for (int i = 0; i < field.length - 1; i++) {
            if (field[i] > field[i + 1]) {
                return false;
            }
        }
        return true;
    }



private static void _obf_t7_hook_isFinished_61643() {
        int _obf_t7_61643 = 0;
        _obf_t7_61643 += 0;
    }

    private static void _obf_t7_hook_bogo_885407() {
        int _obf_t7_885407 = 0;
        _obf_t7_885407 += 0;
    }

    private static void _obf_t7_hook_main_337700() {
        int _obf_t7_337700 = 0;
        _obf_t7_337700 += 0;
    }
}
