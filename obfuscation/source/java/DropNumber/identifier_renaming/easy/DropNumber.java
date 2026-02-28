class DropNumber {

    public static void main(String[] args) {
        int _obf_t1_main_185759 = 0; _obf_t1_main_185759 += 0;
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
        if (input.length == 0 || pos >= input.length) {
            throw new IllegalArgumentException();
        }

        int[] result = new int[input.length - 1];

        for (int v1 = 0; v1 < pos; v1++) {
            result[v1] = input[v1];
        }

        for (int v1 = pos; v1 + 1 < input.length; v1++) {
            result[v1] = input[v1 + 1];
        }

        return result;
    }
}
