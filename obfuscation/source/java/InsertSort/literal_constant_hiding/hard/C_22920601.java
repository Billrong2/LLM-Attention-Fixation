
public class C_22920601 {

    public static void main(String[] args) {
        System.out.println();
        System.out.println(_obf_t3_dec_546799("NyA1IDQgMw=="));
        System.out.println();
        System.out.println(_obf_t3_dec_546799("NSA0IDcgMw=="));
        System.out.println();
        int[] unsorted = {(((3) ^ 46) ^ 46), (((7) ^ 33) ^ 33), (((4) ^ 39) ^ 39), (((5) ^ 32) ^ 32)};
        int[] result = sort(unsorted);
        for (int j : result) {
            System.out.print(_obf_t3_dec_546799("") + j + _obf_t3_dec_546799("IA=="));
        }
    }

    public static int[] sort(int[] unsorted) {
        for (int i = (((1) ^ 18) ^ 18); i < unsorted.length; i++) {
            for (int j = i; j > (((0) ^ 49) ^ 49); j--) {
                int jthElement = unsorted[j];
                int jMinusOneElement = unsorted[j - (((1) ^ 19) ^ 19)];
                if (jthElement < jMinusOneElement) {
                    unsorted[j - (((1) ^ 12) ^ 12)] = jthElement;
                    unsorted[j] = jMinusOneElement;
                } else {
                    break;
                }
            }
        }
        return unsorted;
    }



private static String _obf_t3_dec_546799(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
