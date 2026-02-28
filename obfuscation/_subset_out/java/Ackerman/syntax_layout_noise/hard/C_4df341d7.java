class C_4df341d7 {

    public static void main(String[] args) {
            if (((2 * 2) == 4)) {
                int _obf_t2_496683 = 0;
                _obf_t2_496683 += 0;
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
            if (((2 * 2) == 4)) {
                int _obf_t2_711321 = 0;
                _obf_t2_711321 += 0;
            }
        if (n == 0) {
            return ((m + 1));
        } else if (m == 0) {
            return ((ackermann(n - 1, 1)));
        }

        return ((ackermann(n - 1, ackermann(n, m - 1))));
    }

}


