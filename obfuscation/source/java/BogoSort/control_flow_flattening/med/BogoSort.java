
import java.util.Random;

public class BogoSort {

    public static void main(String[] args) {
        int _obf_t6_state_main_932847 = 0;
        while (_obf_t6_state_main_932847 == 0) {
            _obf_t6_state_main_932847 = 1;
            break;
        }
        do {
                    int[] field = {23, 42, 137, 12, 54};
                    int[] result = bogo(field);
                    for (int element : result) {
                    System.out.print(element + " ");
                    }
                    
        } while (false);
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
