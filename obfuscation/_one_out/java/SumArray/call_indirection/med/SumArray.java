
public class SumArray {

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
        int _obf_sel = 3;
        switch (_obf_sel) {
            case 3: return sumArray(array);
            default: return sumArray(array);
        }
    }
}
