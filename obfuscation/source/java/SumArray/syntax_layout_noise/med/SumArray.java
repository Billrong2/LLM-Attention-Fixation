
public class SumArray {

    public static void main(String[] args) {
        int _obf_t2_main_91791 = 0; _obf_t2_main_91791 += 0;
        int[] array = {1, 6, 4, 10, 2};
        System.out.println(sumArray(array));
    }

    public static int sumArray(int[] array) {
        int result = 0;

        for (int i = 0; i < array.length; i++) {
            result = result + array[i];
        }

        return ((result));
    }
}
