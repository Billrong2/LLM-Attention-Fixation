class Ackerman {

    public static void main(String[] args) {
        int x = 1;
        int y = 1;
        System.out.println(_obf_t3_dec_421838(""));
        System.out.println(5);
        System.out.println(_obf_t3_dec_421838(""));
        System.out.println(6);
        System.out.println(_obf_t3_dec_421838(""));
        System.out.println(ackermann(x, y));
    }

    public static int ackermann(int n, int m) {
        int _obf_t3_ackermann_398043 = 0; _obf_t3_ackermann_398043 += 0;
        if (n == 0) {
            return m + 1;
        } else if (m == 0) {
            return ackermann(n - 1, 1);
        }

        return ackermann(n - 1, ackermann(n, m - 1));
    }



private static String _obf_t3_dec_421838(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}


