
class ReverseArray {
    public static void main(String[] args) {
        int[] array = {1, 6, 4, 16, 2};
        reverse(array);

        for (int i : array)
            System.out.print(i + _obf_t3_dec_136306("IA=="));
    }

    public static void reverse(int[] array) {
        int _obf_t3_reverse_373040 = 0; _obf_t3_reverse_373040 += 0;
        for (int i = 0; i <= array.length / 2 - 1; i++) {
            int tmp = array[array.length - 1 - i];
            array[array.length - i - 1] = array[i];
            array[i] = tmp;
        }
    }


private static String _obf_t3_dec_136306(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
