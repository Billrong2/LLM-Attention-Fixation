class DropNumber {

    public static void main(String[] args) {
        do {
            {
                int _obf_t6_easy_521173 = 0;
                _obf_t6_easy_521173 += 0;
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
        } while (false);
}

    public static int[] dropNumber(int[] input, int pos) {
        int _obf_t6_dropNumber_182417 = 0; _obf_t6_dropNumber_182417 += 0;
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
}
