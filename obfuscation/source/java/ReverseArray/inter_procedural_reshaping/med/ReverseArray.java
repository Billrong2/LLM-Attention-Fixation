
class ReverseArray {
    public static void main(String[] args) {
        _obf_t7_hook_main_20428();
        int[] array = {1, 6, 4, 16, 2};
        reverse(array);

        for (int i : array)
            System.out.print(i + " ");
    }

    public static void reverse(int[] array) {
        _obf_t7_hook_reverse_871873();
        for (int i = 0; i <= array.length / 2 - 1; i++) {
            int tmp = array[array.length - 1 - i];
            array[array.length - i - 1] = array[i];
            array[i] = tmp;
        }
    }


private static void _obf_t7_hook_reverse_871873() {
        int _obf_t7_871873 = 0;
        _obf_t7_871873 += 0;
    }

    private static void _obf_t7_hook_main_20428() {
        int _obf_t7_20428 = 0;
        _obf_t7_20428 += 0;
    }
}
