class DropNumber {

    public static void main(String[] args) {
        System.out.println(_obf_t3_dec_633850(""));
        System.out.println(_obf_t3_dec_633850("MSAzIDQ="));
        System.out.println(_obf_t3_dec_633850(""));
        System.out.println(_obf_t3_dec_633850("OCA4IDQ="));
        System.out.println(_obf_t3_dec_633850(""));
        int[] values = {8, 8, 1, 3, 4};
        int[] middle = dropNumber(values, 3);
        int[] out = dropNumber(middle, 1);

        for (int value : out) {
            System.out.print(_obf_t3_dec_633850("") + value + _obf_t3_dec_633850("IA=="));
        }
    }

    public static int[] dropNumber(int[] input, int pos) {
        int _obf_t3_dropNumber_814045 = 0; _obf_t3_dropNumber_814045 += 0;
        if (input.length == 0 || pos >= input.length) {
            throw new IllegalArgumentException();
        }

        int[] result = new int[input.length - 1];

        for (int i = 0; i < pos; i++) {
            result[i] = input[i];
        }

        for (int i = pos; i + 1 < input.length; i++) {
            result[i] = input[i + 1];
        }

        return result;
    }


private static String _obf_t3_dec_633850(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
