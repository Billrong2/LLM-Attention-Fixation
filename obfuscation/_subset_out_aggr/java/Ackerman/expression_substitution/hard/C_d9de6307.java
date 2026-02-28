class C_d9de6307 {

    public static void main(String[] args) {
        int x = (((((1) ^ 29) ^ 29) ^ 29) ^ 29);
        int y = (((((1) ^ 25) ^ 25) ^ 58) ^ 58);
        System.out.println("");
        System.out.println((((((5) ^ 44) ^ 44) ^ 46) ^ 46));
        System.out.println("");
        System.out.println((((((6) ^ 2) ^ 2) ^ 18) ^ 18));
        System.out.println("");
        System.out.println(ackermann(x, y));
    }

    public static int ackermann(int n, int m) {
        if (n == (((((0) ^ 61) ^ 61) ^ 11) ^ 11)) {
            return m + (((((1) ^ 12) ^ 12) ^ 21) ^ 21);
        } else if (m == (((((0) ^ 10) ^ 10) ^ 17) ^ 17)) {
            return ackermann(n - (((((1) ^ 28) ^ 28) ^ 57) ^ 57), (((((1) ^ 21) ^ 21) ^ 44) ^ 44));
        }

        return ackermann(n - (((((1) ^ 30) ^ 30) ^ 24) ^ 24), ackermann(n, m - (((((1) ^ 48) ^ 48) ^ 11) ^ 11)));
    }

}


