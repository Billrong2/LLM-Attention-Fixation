
import java.util.Random;

public class BogoSort {

    public static void main(String[] args) {
        do {
            {
                int _obf_t6_easy_932847 = 0;
                _obf_t6_easy_932847 += 0;
                    int[] field = {23, 42, 137, 12, 54};
                    int[] result = bogo(field);
                    for (int element : result) {
                    System.out.print(element + " ");
                    }
                    
            }
        } while (false);
}

    public static int[] bogo(int[] field) {
        do {
            {
                int _obf_t6_easy_875044 = 0;
                _obf_t6_easy_875044 += 0;
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
        } while (false);
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
