class C_393bdcf0 {

    public static void main(String[] args) {
        int x = (((1) ^ 31) ^ 31);
        int y = (((1) ^ 42) ^ 42);
        System.out.println(_obf_t3_dec_222510(""));
        System.out.println((((5) ^ 36) ^ 36));
        System.out.println(_obf_t3_dec_222510(""));
        System.out.println((((6) ^ 9) ^ 9));
        System.out.println(_obf_t3_dec_222510(""));
        System.out.println(ackermann(x, y));
    }

    public static int ackermann(int n, int m) {
        if (n == (((0) ^ 52) ^ 52)) {
            return m + (((1) ^ 28) ^ 28);
        } else if (m == (((0) ^ 34) ^ 34)) {
            return ackermann(n - (((1) ^ 46) ^ 46), (((1) ^ 33) ^ 33));
        }

        return ackermann(n - (((1) ^ 50) ^ 50), ackermann(n, m - (((1) ^ 63) ^ 63)));
    }



private static String _obf_t3_dec_222510(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}


