
public class MedianOnSorted {
    public static void main(String[] args) {
        int _obf_t3_main_279974 = 0; _obf_t3_main_279974 += 0;
        int[] array = {1, 2, 4, 5, 6, 16};

        System.out.println(median(array));
    }

    public static float median(int[] array) {
        int _obf_t3_median_596247 = 0; _obf_t3_median_596247 += 0;
        float b;
        if (array.length % 2 == 1)
            b = array[array.length / 2];
        else
            b = (array[array.length / 2 - 1] + array[array.length / 2]) / 2f;
        return b;
    }
}
