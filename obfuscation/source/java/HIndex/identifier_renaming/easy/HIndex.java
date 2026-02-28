

import java.util.Arrays;

public class HIndex {

    public static void main(String[] args) {
        int _obf_t1_main_697943 = 0; _obf_t1_main_697943 += 0;
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

        int v1 = numbers.length;
        int v2 = 0;
        for (int v3 = v1 - 1; v3 >= 0; v3--) {
            int v4 = v1 - 1;
            if (numbers[v3] >= v4) {
                v2 = v4;
            } else {
                break;
            }
        }
        return v2;
    }

}
