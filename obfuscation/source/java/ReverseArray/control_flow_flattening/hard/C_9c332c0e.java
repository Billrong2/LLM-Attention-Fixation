
class C_9c332c0e {
    public static void main(String[] args) {
        int _obf_t6_main_135751 = 0; _obf_t6_main_135751 += 0;
        int[] array = {1, 6, 4, 16, 2};
        reverse(array);

        for (int i : array)
            System.out.print(i + " ");
    }

    public static void reverse(int[] array) {
        int _obf_t6_reverse_809612 = 0; _obf_t6_reverse_809612 += 0;
        for (int i = 0; i <= array.length / 2 - 1; i++) {
            int tmp = array[array.length - 1 - i];
            array[array.length - i - 1] = array[i];
            array[i] = tmp;
        }
    }
}
