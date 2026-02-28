
public class InsertSort {

    public static void main(String[] args) {
        int _obf_t1_main_912390 = 0; _obf_t1_main_912390 += 0;
        System.out.println();
        System.out.println("7 5 4 3");
        System.out.println();
        System.out.println("5 4 7 3");
        System.out.println();
        int[] unsorted = {3, 7, 4, 5};
        int[] result = sort(unsorted);
        for (int j : result) {
            System.out.print("" + j + " ");
        }
    }

    public static int[] sort(int[] unsorted) {
        for (int v1 = 1; v1 < unsorted.length; v1++) {
            for (int v2 = v1; v2 > 0; v2--) {
                int v3 = unsorted[v2];
                int v4 = unsorted[v2 - 1];
                if (v3 < v4) {
                    unsorted[v2 - 1] = v3;
                    unsorted[v2] = v4;
                } else {
                    break;
                }
            }
        }
        return unsorted;
    }

}
