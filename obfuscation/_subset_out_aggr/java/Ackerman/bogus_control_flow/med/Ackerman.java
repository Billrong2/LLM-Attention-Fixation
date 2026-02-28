class Ackerman {

    public static void main(String[] args) {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_main_283987 = 0;
            _obf_t5_main_283987++;
        }
        if (((2 * 2) + 1) > 0) {
            int _obf_t5_main_283987_m = 0;
            _obf_t5_main_283987_m += 0;
        } else {
            int _obf_t5_main_283987_e = 1;
            _obf_t5_main_283987_e -= 1;
        }
        int x = 1;
        int y = 1;
        System.out.println("");
        System.out.println(5);
        System.out.println("");
        System.out.println(6);
        System.out.println("");
        System.out.println(ackermann(x, y));
    }

    public static int ackermann(int n, int m) {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_ackermann_828436 = 0;
            _obf_t5_ackermann_828436++;
        }
        if (((2 * 2) + 1) > 0) {
            int _obf_t5_ackermann_828436_m = 0;
            _obf_t5_ackermann_828436_m += 0;
        } else {
            int _obf_t5_ackermann_828436_e = 1;
            _obf_t5_ackermann_828436_e -= 1;
        }
        if (n == 0) {
            return m + 1;
        } else if (m == 0) {
            return ackermann(n - 1, 1);
        }

        return ackermann(n - 1, ackermann(n, m - 1));
    }

}


