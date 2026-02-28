

import java.util.Arrays;

public class HIndex {

    public static void main(String[] args) {
        System.out.println();
        System.out.println("1");
        System.out.println();
        System.out.println("9");
        System.out.println();
        int[] numbers = {2, 4, 1, 4, 9};
        System.out.println(_obf_t8_hIndex_375006(numbers));
    }

    public static int hIndex(int[] numbers) {
        int _obf_t8_hIndex_331989 = 0; _obf_t8_hIndex_331989 += 0;
        Arrays.sort(numbers);

        int count = numbers.length;
        int hIndex = 0;
        for (int i = count - 1; i >= 0; i--) {
            int current = count - 1;
            if (numbers[i] >= current) {
                hIndex = current;
            } else {
                break;
            }
        }
        return hIndex;
    }



private static int _obf_t8_hIndex_375006(int[] numbers) {
        return hIndex(numbers);
    }
}
