
import java.util.Random;

public class C_d5a1b140 {

    public static void main(String[] args) {
        int[] field = {(((23) ^ 5) ^ 5), (((42) ^ 8) ^ 8), (((137) ^ 30) ^ 30), (((12) ^ 26) ^ 26), (((54) ^ 3) ^ 3)};
        int[] result = bogo(field);
        for (int element : result) {
            System.out.print(element + _obf_t3_dec_742450("IA=="));
        }
    }

    public static int[] bogo(int[] field) {
        int _obf_t3_bogo_141767 = 0; _obf_t3_bogo_141767 += 0;
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
        for (int i = (((0) ^ 55) ^ 55); i < field.length - (((1) ^ 27) ^ 27); i++) {
            if (field[i] > field[i + (((1) ^ 15) ^ 15)]) {
                return false;
            }
        }
        return true;
    }



private static String _obf_t3_dec_742450(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
