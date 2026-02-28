
public class InsertSort {

    public static void main(String[] args) {
        System.out.println();
        System.out.println(_obf_t3_dec_546799("NyA1IDQgMw=="));
        System.out.println();
        System.out.println(_obf_t3_dec_546799("NSA0IDcgMw=="));
        System.out.println();
        int[] unsorted = {3, 7, 4, 5};
        int[] result = sort(unsorted);
        for (int j : result) {
            System.out.print(_obf_t3_dec_546799("") + j + _obf_t3_dec_546799("IA=="));
        }
    }

    public static int[] sort(int[] unsorted) {
        int _obf_t3_sort_671123 = 0; _obf_t3_sort_671123 += 0;
        for (int i = 1; i < unsorted.length; i++) {
            for (int j = i; j > 0; j--) {
                int jthElement = unsorted[j];
                int jMinusOneElement = unsorted[j - 1];
                if (jthElement < jMinusOneElement) {
                    unsorted[j - 1] = jthElement;
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
