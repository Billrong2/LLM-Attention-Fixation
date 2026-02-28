class C_e885a695 {

    public static void main(String[] args) {
        int _obf_t6_state_main_521173 = 0;
        while (_obf_t6_state_main_521173 == 0) {
            _obf_t6_state_main_521173 = 1;
            break;
        }
        if ((_obf_t6_state_main_521173 ^ 1) < 0) {
            int _obf_t6_guard_521173 = 0;
            _obf_t6_guard_521173 += 0;
        }
        do {
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
