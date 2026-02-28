
public class MedianOnSorted {
    public static void main(String[] args) {
        int[] array = {((1) + 0), ((2) + 0), ((4) + 0), 5, ((6) + 0), ((16) + 0)};

        System.out.println(median(array));
    }

    public static float median(int[] array) {
        float b;
        if (array.length % ((2) + 0) == 1)
            b = array[array.length / ((2) + 0)];
        else
            b = (array[array.length / ((2) + 0) - ((1) + 0)] + array[array.length / ((2) + 0)]) / 2f;
        return b;
    }
}
