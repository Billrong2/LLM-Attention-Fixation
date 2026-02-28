

import java.util.Arrays;

public class C_a350e795 {

    public static void main(String[] args) {
        System.out.println();
        System.out.println(_obf_t3_dec_389939("MQ=="));
        System.out.println();
        System.out.println(_obf_t3_dec_389939("OQ=="));
        System.out.println();
        int[] numbers = {(((2) ^ 38) ^ 38), (((4) ^ 14) ^ 14), (((1) ^ 12) ^ 12), (((4) ^ 51) ^ 51), (((9) ^ 16) ^ 16)};
        System.out.println(hIndex(numbers));
    }

    public static int hIndex(int[] numbers) {
        Arrays.sort(numbers);

        int count = numbers.length;
        int hIndex = (((0) ^ 12) ^ 12);
        for (int i = count - (((1) ^ 39) ^ 39); i >= (((0) ^ 6) ^ 6); i--) {
            int current = count - (((1) ^ 34) ^ 34);
            if (numbers[i] >= current) {
                hIndex = current;
            } else {
                break;
            }
        }
        return hIndex;
    }



private static String _obf_t3_dec_389939(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
