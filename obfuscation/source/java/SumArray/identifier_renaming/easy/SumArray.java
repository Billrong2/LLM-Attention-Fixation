
public class SumArray {

    public static void main(String[] args) {
        int _obf_t1_main_251045 = 0; _obf_t1_main_251045 += 0;
        int[] array = {1, 6, 4, 10, 2};
        System.out.println(sumArray(array));
    }

    public static int sumArray(int[] array) {
        int v1 = 0;

        for (int v2 = 0; v2 < array.length; v2++) {
            v1 = v1 + array[v2];
        }

        return v1;
    }
}
