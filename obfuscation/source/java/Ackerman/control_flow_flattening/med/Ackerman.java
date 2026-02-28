class Ackerman {

    public static void main(String[] args) {
        int _obf_t6_state_main_995898 = 0;
        while (_obf_t6_state_main_995898 == 0) {
            _obf_t6_state_main_995898 = 1;
            break;
        }
        do {
                    int x = 1;
                    int y = 1;
                    System.out.println("");
                    System.out.println(5);
                    System.out.println("");
                    System.out.println(6);
                    System.out.println("");
                    System.out.println(ackermann(x, y));
                    
        } while (false);
}

    public static int ackermann(int n, int m) {
        int _obf_t6_ackermann_833856 = 0; _obf_t6_ackermann_833856 += 0;
        if (n == 0) {
            return m + 1;
        } else if (m == 0) {
            return ackermann(n - 1, 1);
        }

        return ackermann(n - 1, ackermann(n, m - 1));
    }

}


