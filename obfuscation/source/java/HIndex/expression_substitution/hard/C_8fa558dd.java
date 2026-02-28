

import java.util.Arrays;

public class C_8fa558dd {

    public static void main(String[] args) {
        int _obf_t4_main_589515 = 0; _obf_t4_main_589515 += 0;
        System.out.println();
        System.out.println("1");
        System.out.println();
        System.out.println("9");
        System.out.println();
        int[] numbers = {2, 4, 1, 4, 9};
        System.out.println(hIndex(numbers));
    }

    public static int hIndex(int[] numbers) {
        Arrays.sort(numbers);

        int count = numbers.length;
        int hIndex = ((((0) ^ 57) ^ 57) + 0);
        for (int i = count - ((((1) ^ 17) ^ 17) + 0); i >= ((((0) ^ 46) ^ 46) + 0); i--) {
            int current = count - ((((1) ^ 14) ^ 14) + 0);
            if (numbers[i] >= current) {
                hIndex = current;
            } else {
                break;
            }
        }
        return hIndex;
    }

}
