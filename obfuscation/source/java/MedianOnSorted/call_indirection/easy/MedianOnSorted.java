
public class MedianOnSorted {
    public static void main(String[] args) {
        int[] array = {1, 2, 4, 5, 6, 16};

        System.out.println(_obf_t8_median_200338(array));
    }

    public static float median(int[] array) {
        int _obf_t8_median_509431 = 0; _obf_t8_median_509431 += 0;
        float b;
        if (array.length % 2 == 1)
            b = array[array.length / 2];
        else
            b = (array[array.length / 2 - 1] + array[array.length / 2]) / 2f;
        return b;
    }


private static float _obf_t8_median_200338(int[] array) {
        return median(array);
    }
}
