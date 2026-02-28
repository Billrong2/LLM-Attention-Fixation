

import java.util.Arrays;

public class HIndex {

    public static void main(String[] args) {
        System.out.println();
        System.out.println("1");
        System.out.println();
        System.out.println("9");
        System.out.println();
        int[] numbers = {(((2) ^ 22) ^ 22), 4, (((1) ^ 26) ^ 26), 4, (((9) ^ 28) ^ 28)};
        System.out.println(hIndex(numbers));
    }

    public static int hIndex(int[] numbers) {
        Arrays.sort(numbers);

        int count = numbers.length;
        int hIndex = (((0) ^ 29) ^ 29);
        for (int i = count - (((1) ^ 9) ^ 9); i >= (((0) ^ 24) ^ 24); i--) {
            int current = count - (((1) ^ 8) ^ 8);
            if (numbers[i] >= current) {
                hIndex = current;
            } else {
                break;
            }
        }
        return hIndex;
    }

}
