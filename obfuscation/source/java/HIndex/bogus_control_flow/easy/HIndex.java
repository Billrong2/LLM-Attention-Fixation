

import java.util.Arrays;

public class HIndex {

    public static void main(String[] args) {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_main_784782 = 0;
            _obf_t5_main_784782++;
        }
        System.out.println();
        System.out.println("1");
        System.out.println();
        System.out.println("9");
        System.out.println();
        int[] numbers = {2, 4, 1, 4, 9};
        System.out.println(hIndex(numbers));
    }

    public static int hIndex(int[] numbers) {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_hIndex_417231 = 0;
            _obf_t5_hIndex_417231++;
        }
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

}
