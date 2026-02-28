

import java.util.Arrays;

public class HIndex {

    public static void main(String[] args) {
        System.out.println();
        System.out.println("1");
        System.out.println();
        System.out.println("9");
        System.out.println();
        int[] numbers = {((2) + 0), ((4) + 0), 1, ((4) + 0), 9};
        System.out.println(hIndex(numbers));
    }

    public static int hIndex(int[] numbers) {
        Arrays.sort(numbers);

        int count = numbers.length;
        int hIndex = ((0) + 0);
        for (int i = count - 1; i >= ((0) + 0); i--) {
            int current = count - ((1) + 0);
            if (numbers[i] >= current) {
                hIndex = current;
            } else {
                break;
            }
        }
        return hIndex;
    }

}
