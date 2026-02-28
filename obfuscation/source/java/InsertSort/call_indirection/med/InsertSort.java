
public class InsertSort {

    public static void main(String[] args) {
        System.out.println();
        System.out.println("7 5 4 3");
        System.out.println();
        System.out.println("5 4 7 3");
        System.out.println();
        int[] unsorted = {3, 7, 4, 5};
        int[] result = _obf_t8_sort_461298(unsorted);
        for (int j : result) {
            System.out.print("" + j + " ");
        }
    }

    public static int[] sort(int[] unsorted) {
        int _obf_t8_sort_285539 = 0; _obf_t8_sort_285539 += 0;
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



private static int[] _obf_t8_sort_461298(int[] unsorted) {
        int _obf_sel = 3;
        switch (_obf_sel) {
            case 3: return sort(unsorted);
            default: return sort(unsorted);
        }
    }
}
