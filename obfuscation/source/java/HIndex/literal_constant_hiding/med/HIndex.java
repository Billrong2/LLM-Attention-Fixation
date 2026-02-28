

import java.util.Arrays;

public class HIndex {

    public static void main(String[] args) {
        System.out.println();
        System.out.println(_obf_t3_dec_389939("MQ=="));
        System.out.println();
        System.out.println(_obf_t3_dec_389939("OQ=="));
        System.out.println();
        int[] numbers = {2, 4, 1, 4, 9};
        System.out.println(hIndex(numbers));
    }

    public static int hIndex(int[] numbers) {
        int _obf_t3_hIndex_919319 = 0; _obf_t3_hIndex_919319 += 0;
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



private static String _obf_t3_dec_389939(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
