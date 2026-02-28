class Ackerman {

    public static void main(String[] args) {
        int x = (((1) ^ 15) ^ 15);
        int y = (((1) ^ 9) ^ 9);
        System.out.println("");
        System.out.println((((5) ^ 18) ^ 18));
        System.out.println("");
        System.out.println(6);
        System.out.println("");
        System.out.println(ackermann(x, y));
    }

    public static int ackermann(int n, int m) {
        if (n == (((0) ^ 31) ^ 31)) {
            return m + (((1) ^ 24) ^ 24);
        } else if (m == (((0) ^ 12) ^ 12)) {
            return ackermann(n - (((1) ^ 9) ^ 9), (((1) ^ 15) ^ 15));
        }

        return ackermann(n - 1, ackermann(n, m - 1));
    }

}


