

import java.util.Arrays;

public class C_e42a5f51 {

    public static void main(String[] args) {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_main_784782 = 0;
            _obf_t5_main_784782++;
        }
        if (((2 * 2) + 1) > 0) {
            int _obf_t5_main_784782_m = 0;
            _obf_t5_main_784782_m += 0;
        } else {
            int _obf_t5_main_784782_e = 1;
            _obf_t5_main_784782_e -= 1;
        }
        int _obf_t5_main_784782_h = (1 ^ 1);
        if (_obf_t5_main_784782_h != 0) {
            _obf_t5_main_784782_h += 1;
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
        int _obf_t5_hIndex_342684 = 0; _obf_t5_hIndex_342684 += 0;
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
