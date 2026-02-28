class DropNumber {

    public static void main(String[] args) {
        _obf_t7_hook_main_340888();
        System.out.println("");
        System.out.println("1 3 4");
        System.out.println("");
        System.out.println("8 8 4");
        System.out.println("");
        int[] values = {8, 8, 1, 3, 4};
        int[] middle = dropNumber(values, 3);
        int[] out = dropNumber(middle, 1);

        for (int value : out) {
            System.out.print("" + value + " ");
        }
    }

    public static int[] dropNumber(int[] input, int pos) {
        _obf_t7_hook_dropNumber_288177();
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


private static void _obf_t7_hook_dropNumber_288177() {
        int _obf_t7_288177 = 0;
        _obf_t7_288177 += 0;
    }

    private static void _obf_t7_hook_main_340888() {
        int _obf_t7_340888 = 0;
        _obf_t7_340888 += 0;
    }
}
