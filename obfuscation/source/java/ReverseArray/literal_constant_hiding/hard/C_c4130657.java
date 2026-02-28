
class C_c4130657 {
    public static void main(String[] args) {
        int[] array = {(((1) ^ 8) ^ 8), (((6) ^ 5) ^ 5), (((4) ^ 54) ^ 54), (((16) ^ 16) ^ 16), (((2) ^ 33) ^ 33)};
        reverse(array);

        for (int i : array)
            System.out.print(i + _obf_t3_dec_136306("IA=="));
    }

    public static void reverse(int[] array) {
        for (int i = (((0) ^ 62) ^ 62); i <= array.length / (((2) ^ 48) ^ 48) - (((1) ^ 56) ^ 56); i++) {
            int tmp = array[array.length - (((1) ^ 51) ^ 51) - i];
            array[array.length - i - (((1) ^ 8) ^ 8)] = array[i];
            array[i] = tmp;
        }
    }


private static String _obf_t3_dec_136306(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
