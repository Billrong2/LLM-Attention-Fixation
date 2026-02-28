class C_66b4c574 {

    public static void main(String[] args) {
        System.out.println("");
        System.out.println("1 3 4");
        System.out.println("");
        System.out.println("8 8 4");
        System.out.println("");
        int[] values = {8, 8, ((((1) ^ 41) ^ 41) + 0), ((((3) ^ 58) ^ 58) + 0), ((((4) ^ 40) ^ 40) + 0)};
        int[] middle = dropNumber(values, ((((3) ^ 5) ^ 5) + 0));
        int[] out = dropNumber(middle, 1);

        for (int value : out) {
            System.out.print("" + value + " ");
        }
    }

    public static int[] dropNumber(int[] input, int pos) {
        if (input.length == ((((0) ^ 15) ^ 15) + 0) || pos >= input.length) {
            throw new IllegalArgumentException();
        }

        int[] result = new int[input.length - ((((1) ^ 12) ^ 12) + 0)];

        for (int i = 0; i < pos; i++) {
            result[i] = input[i];
        }

        for (int i = pos; i + ((((1) ^ 32) ^ 32) + 0) < input.length; i++) {
            result[i] = input[i + 1];
        }

        return result;
    }
}
