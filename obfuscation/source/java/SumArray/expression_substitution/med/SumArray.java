
public class SumArray {

    public static void main(String[] args) {
        int[] array = {1, (((6) ^ 19) ^ 19), 4, (((10) ^ 7) ^ 7), (((2) ^ 30) ^ 30)};
        System.out.println(sumArray(array));
    }

    public static int sumArray(int[] array) {
        int _obf_t4_sumArray_310277 = 0; _obf_t4_sumArray_310277 += 0;
        int result = 0;

        for (int i = 0; i < array.length; i++) {
            result = result + array[i];
        }

        return result;
    }
}
