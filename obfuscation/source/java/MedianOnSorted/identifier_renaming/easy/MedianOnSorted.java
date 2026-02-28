
public class MedianOnSorted {
    public static void main(String[] args) {
        int _obf_t1_main_890693 = 0; _obf_t1_main_890693 += 0;
        int[] array = {1, 2, 4, 5, 6, 16};

        System.out.println(median(array));
    }

    public static float median(int[] array) {
        float v1;
        if (array.length % 2 == 1)
            v1 = array[array.length / 2];
        else
            v1 = (array[array.length / 2 - 1] + array[array.length / 2]) / 2f;
        return v1;
    }
}
