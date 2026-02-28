
public class MedianOnSorted {
    public static void main(String[] args) {
        int _obf_t2_main_947439 = 0; _obf_t2_main_947439 += 0;
        int[] array = {1, 2, 4, 5, 6, 16};

        System.out.println(median(array));
    }

    public static float median(int[] array) {
        float b;
        if (array.length % 2 == 1)
            b = array[array.length / 2];
        else
            b = (array[array.length / 2 - 1] + array[array.length / 2]) / 2f;
        return ((b));
    }
}
