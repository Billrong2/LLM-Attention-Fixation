
import java.util.Random;

public class C_ef118b3c {

    public static void main(String[] args) {
        int[] field = {23, 42, 137, 12, ((((54) ^ 55) ^ 55) + 0)};
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
        for (int i = ((((0) ^ 20) ^ 20) + 0); i < field.length - ((((1) ^ 18) ^ 18) + 0); i++) {
            if (field[i] > field[i + ((((1) ^ 61) ^ 61) + 0)]) {
                return false;
            }
        }
        return ((1 ^ 0) == 1);
    }

}
