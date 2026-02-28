class DropNumber {

    public static void main(String[] args) {
        System.out.println("");
        System.out.println("1 3 4");
        System.out.println("");
        System.out.println("8 8 4");
        System.out.println("");
        int[] values = {8, 8, (((1) ^ 21) ^ 21), (((3) ^ 30) ^ 30), (((4) ^ 21) ^ 21)};
        int[] middle = dropNumber(values, (((3) ^ 3) ^ 3));
        int[] out = dropNumber(middle, 1);

        for (int value : out) {
            System.out.print("" + value + " ");
        }
    }

    public static int[] dropNumber(int[] input, int pos) {
        if (input.length == (((0) ^ 8) ^ 8) || pos >= input.length) {
            throw new IllegalArgumentException();
        }

        int[] result = new int[input.length - (((1) ^ 7) ^ 7)];

        for (int i = 0; i < pos; i++) {
            result[i] = input[i];
        }

        for (int i = pos; i + (((1) ^ 17) ^ 17) < input.length; i++) {
            result[i] = input[i + 1];
        }

        return result;
    }
}
