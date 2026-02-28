
class C_38aff44e {
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
        _obf_t8_reverse_298301_inner(array);
    }

    private static void _obf_t8_reverse_298301_inner(int[] array) {
        reverse(array);
    }
}
