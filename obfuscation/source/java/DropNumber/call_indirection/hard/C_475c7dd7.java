class C_475c7dd7 {

    public static void main(String[] args) {
        System.out.println("");
        System.out.println("1 3 4");
        System.out.println("");
        System.out.println("8 8 4");
        System.out.println("");
        int[] values = {8, 8, 1, 3, 4};
        int[] middle = _obf_t8_dropNumber_560281(values, 3);
        int[] out = _obf_t8_dropNumber_560281(middle, 1);

        for (int value : out) {
            System.out.print("" + value + " ");
        }
    }

    public static int[] dropNumber(int[] input, int pos) {
        int _obf_t8_dropNumber_592671 = 0; _obf_t8_dropNumber_592671 += 0;
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


private static int[] _obf_t8_dropNumber_560281(int[] input, int pos) {
        return _obf_t8_dropNumber_560281_inner(input, pos);
    }

    private static int[] _obf_t8_dropNumber_560281_inner(int[] input, int pos) {
        return dropNumber(input, pos);
    }
}
