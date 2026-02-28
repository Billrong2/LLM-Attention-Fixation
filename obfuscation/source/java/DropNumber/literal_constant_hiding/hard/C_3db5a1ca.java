class C_3db5a1ca {

    public static void main(String[] args) {
        System.out.println(_obf_t3_dec_633850(""));
        System.out.println(_obf_t3_dec_633850("MSAzIDQ="));
        System.out.println(_obf_t3_dec_633850(""));
        System.out.println(_obf_t3_dec_633850("OCA4IDQ="));
        System.out.println(_obf_t3_dec_633850(""));
        int[] values = {(((8) ^ 31) ^ 31), (((8) ^ 37) ^ 37), (((1) ^ 18) ^ 18), (((3) ^ 12) ^ 12), (((4) ^ 13) ^ 13)};
        int[] middle = dropNumber(values, (((3) ^ 39) ^ 39));
        int[] out = dropNumber(middle, (((1) ^ 23) ^ 23));

        for (int value : out) {
            System.out.print(_obf_t3_dec_633850("") + value + _obf_t3_dec_633850("IA=="));
        }
    }

    public static int[] dropNumber(int[] input, int pos) {
        if (input.length == (((0) ^ 18) ^ 18) || pos >= input.length) {
            throw new IllegalArgumentException();
        }

        int[] result = new int[input.length - (((1) ^ 39) ^ 39)];

        for (int i = (((0) ^ 42) ^ 42); i < pos; i++) {
            result[i] = input[i];
        }

        for (int i = pos; i + (((1) ^ 36) ^ 36) < input.length; i++) {
            result[i] = input[i + (((1) ^ 55) ^ 55)];
        }

        return result;
    }


private static String _obf_t3_dec_633850(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
