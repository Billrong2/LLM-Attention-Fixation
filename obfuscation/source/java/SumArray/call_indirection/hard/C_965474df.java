
public class C_965474df {

    public static void main(String[] args) {
        int[] array = {1, 6, 4, 10, 2};
        System.out.println(_obf_t8_sumArray_532684(array));
    }

    public static int sumArray(int[] array) {
        int _obf_t8_sumArray_715017 = 0; _obf_t8_sumArray_715017 += 0;
        int result = 0;

        for (int i = 0; i < array.length; i++) {
            result = result + array[i];
        }

        return result;
    }


private static int _obf_t8_sumArray_532684(int[] array) {
        return _obf_t8_sumArray_532684_inner(array);
    }

    private static int _obf_t8_sumArray_532684_inner(int[] array) {
        return sumArray(array);
    }
}
