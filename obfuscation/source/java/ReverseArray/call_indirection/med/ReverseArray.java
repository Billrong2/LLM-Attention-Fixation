
class ReverseArray {
    public static void main(String[] args) {
        int[] array = {1, 6, 4, 16, 2};
        _obf_t8_reverse_298301(array);

        for (int i : array)
            System.out.print(i + " ");
    }

    public static void reverse(int[] array) {
        int _obf_t8_reverse_637501 = 0; _obf_t8_reverse_637501 += 0;
        for (int i = 0; i <= array.length / 2 - 1; i++) {
            int tmp = array[array.length - 1 - i];
            array[array.length - i - 1] = array[i];
            array[i] = tmp;
        }
    }


private static void _obf_t8_reverse_298301(int[] array) {
        int _obf_sel = 1;
        switch (_obf_sel) {
            case 1: reverse(array); break;
            default: reverse(array); break;
        }
    }
}
