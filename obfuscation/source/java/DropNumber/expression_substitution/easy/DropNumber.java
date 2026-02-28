class DropNumber {

    public static void main(String[] args) {
        System.out.println("");
        System.out.println("1 3 4");
        System.out.println("");
        System.out.println("8 8 4");
        System.out.println("");
        int[] values = {((8) + 0), ((8) + 0), ((1) + 0), ((3) + 0), ((4) + 0)};
        int[] middle = dropNumber(values, ((3) + 0));
        int[] out = dropNumber(middle, ((1) + 0));

        for (int value : out) {
            System.out.print("" + value + " ");
        }
    }

    public static int[] dropNumber(int[] input, int pos) {
        if (input.length == ((0) + 0) || pos >= input.length) {
            throw new IllegalArgumentException();
        }

        int[] result = new int[input.length - ((1) + 0)];

        for (int i = ((0) + 0); i < pos; i++) {
            result[i] = input[i];
        }

        for (int i = pos; i + ((1) + 0) < input.length; i++) {
            result[i] = input[i + ((1) + 0)];
        }

        return result;
    }
}
