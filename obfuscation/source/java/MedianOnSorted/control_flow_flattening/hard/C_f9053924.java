
public class C_f9053924 {
    public static void main(String[] args) {
        int _obf_t6_main_156871 = 0; _obf_t6_main_156871 += 0;
        int[] array = {1, 2, 4, 5, 6, 16};

        System.out.println(median(array));
    }

    public static float median(int[] array) {
        int _obf_t6_median_299966 = 0; _obf_t6_median_299966 += 0;
        float b;
        if (array.length % 2 == 1)
            b = array[array.length / 2];
        else
            b = (array[array.length / 2 - 1] + array[array.length / 2]) / 2f;
        return b;
    }
}
