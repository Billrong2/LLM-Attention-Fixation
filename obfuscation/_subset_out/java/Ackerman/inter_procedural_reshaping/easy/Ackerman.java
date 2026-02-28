class Ackerman {

    public static void main(String[] args) {
        _obf_t7_hook_main_512236();
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
        _obf_t7_hook_ackermann_778439();
        if (n == 0) {
            return m + 1;
        } else if (m == 0) {
            return ackermann(n - 1, 1);
        }

        return ackermann(n - 1, ackermann(n, m - 1));
    }



private static void _obf_t7_hook_ackermann_778439() {
        int _obf_t7_778439 = 0;
        _obf_t7_778439 += 0;
    }

    private static void _obf_t7_hook_main_512236() {
        int _obf_t7_512236 = 0;
        _obf_t7_512236 += 0;
    }
}


