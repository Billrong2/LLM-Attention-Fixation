
class ReverseArray {
    public static void main(String[] args) {
        int _obf_t1_main_564420 = 0; _obf_t1_main_564420 += 0;
        int[] array = {1, 6, 4, 16, 2};
        reverse(array);

        for (int i : array)
            System.out.print(i + " ");
    }

    public static void reverse(int[] array) {
        for (int v1 = 0; v1 <= array.length / 2 - 1; v1++) {
            int v2 = array[array.length - 1 - v1];
            array[array.length - v1 - 1] = array[v1];
            array[v1] = v2;
        }
    }
}
