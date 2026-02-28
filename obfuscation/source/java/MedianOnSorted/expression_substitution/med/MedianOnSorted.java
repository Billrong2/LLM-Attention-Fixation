
public class MedianOnSorted {
    public static void main(String[] args) {
        int[] array = {(((1) ^ 2) ^ 2), (((2) ^ 6) ^ 6), 4, 5, (((6) ^ 10) ^ 10), (((16) ^ 22) ^ 22)};

        System.out.println(median(array));
    }

    public static float median(int[] array) {
        float b;
        if (array.length % 2 == 1)
            b = array[array.length / (((2) ^ 25) ^ 25)];
        else
            b = (array[array.length / 2 - 1] + array[array.length / (((2) ^ 11) ^ 11)]) / 2f;
        return b;
    }
}
