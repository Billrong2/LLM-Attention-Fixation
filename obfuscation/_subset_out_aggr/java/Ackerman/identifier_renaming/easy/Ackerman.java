class Ackerman {

    public static void main(String[] args) {
        int v1 = 1;
        int v2 = 1;
        System.out.println("");
        System.out.println(5);
        System.out.println("");
        System.out.println(6);
        System.out.println("");
        System.out.println(ackermann(v1, v2));
    }

    public static int ackermann(int n, int m) {
        int _obf_t1_ackermann_56421 = 0; _obf_t1_ackermann_56421 += 0;
        if (n == 0) {
            return m + 1;
        } else if (m == 0) {
            return ackermann(n - 1, 1);
        }

        return ackermann(n - 1, ackermann(n, m - 1));
    }

}


