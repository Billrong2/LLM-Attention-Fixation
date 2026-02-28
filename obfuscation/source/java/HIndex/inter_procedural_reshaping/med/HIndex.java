

import java.util.Arrays;

public class HIndex {

    public static void main(String[] args) {
        _obf_t7_hook_main_60937();
        System.out.println();
        System.out.println("1");
        System.out.println();
        System.out.println("9");
        System.out.println();
        int[] numbers = {2, 4, 1, 4, 9};
        System.out.println(hIndex(numbers));
    }

    public static int hIndex(int[] numbers) {
        _obf_t7_hook_hIndex_217154();
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



private static void _obf_t7_hook_hIndex_217154() {
        int _obf_t7_217154 = 0;
        _obf_t7_217154 += 0;
    }

    private static void _obf_t7_hook_main_60937() {
        int _obf_t7_60937 = 0;
        _obf_t7_60937 += 0;
    }
}
