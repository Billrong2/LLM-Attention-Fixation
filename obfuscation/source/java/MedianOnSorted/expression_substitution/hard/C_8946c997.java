
public class C_8946c997 {
    public static void main(String[] args) {
        int[] array = {((((1) ^ 3) ^ 3) + 0), ((((2) ^ 11) ^ 11) + 0), 4, 5, ((((6) ^ 18) ^ 18) + 0), ((((16) ^ 42) ^ 42) + 0)};

        System.out.println(median(array));
    }

    public static float median(int[] array) {
        float b;
        if (array.length % 2 == 1)
            b = array[array.length / ((((2) ^ 49) ^ 49) + 0)];
        else
            b = (array[array.length / 2 - 1] + array[array.length / ((((2) ^ 20) ^ 20) + 0)]) / 2f;
        return b;
    }
}
