
class C_28290b4e {
    public static void main(String[] args) {
            if (((2 * 2) == 4)) {
                int _obf_t2_848083 = 0;
                _obf_t2_848083 += 0;
            }
        int[] array = {1, 6, 4, 16, 2};
        reverse(array);

        for (int i : array)
            System.out.print(i + " ");
    }

    public static void reverse(int[] array) {
            if (((2 * 2) == 4)) {
                int _obf_t2_451835 = 0;
                _obf_t2_451835 += 0;
            }
        for (int i = 0; i <= array.length / 2 - 1; i++) {
            int tmp = array[array.length - 1 - i];
            array[array.length - i - 1] = array[i];
            array[i] = tmp;
        }
    }
}
