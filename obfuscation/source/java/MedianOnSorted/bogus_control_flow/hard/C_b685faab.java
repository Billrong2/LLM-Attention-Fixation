
public class C_b685faab {
    public static void main(String[] args) {
        int _obf_t5_main_121922 = 0; _obf_t5_main_121922 += 0;
        int[] array = {1, 2, 4, 5, 6, 16};

        System.out.println(median(array));
    }

    public static float median(int[] array) {
        int _obf_t5_median_218122 = 0; _obf_t5_median_218122 += 0;
        float b;
        if (array.length % 2 == 1)
            b = array[array.length / 2];
        else
            b = (array[array.length / 2 - 1] + array[array.length / 2]) / 2f;
        return b;
    }
}
