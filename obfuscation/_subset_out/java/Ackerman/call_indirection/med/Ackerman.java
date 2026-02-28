class Ackerman {

    public static void main(String[] args) {
        int x = 1;
        int y = 1;
        System.out.println("");
        System.out.println(5);
        System.out.println("");
        System.out.println(6);
        System.out.println("");
        System.out.println(_obf_t8_ackermann_76563(x, y));
    }

    public static int ackermann(int n, int m) {
        if (n == 0) {
            return m + 1;
        } else if (m == 0) {
            return _obf_t8_ackermann_76563(n - 1, 1);
        }

        return _obf_t8_ackermann_76563(n - 1, _obf_t8_ackermann_76563(n, m - 1));
    }



private static int _obf_t8_ackermann_76563(int n, int m) {
        int _obf_sel = 3;
        switch (_obf_sel) {
            case 3: return ackermann(n, m);
            default: return ackermann(n, m);
        }
    }
}


