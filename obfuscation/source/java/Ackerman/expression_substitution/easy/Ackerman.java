class Ackerman {

    public static void main(String[] args) {
        int x = ((1) + 0);
        int y = ((1) + 0);
        System.out.println("");
        System.out.println(((5) + 0));
        System.out.println("");
        System.out.println(((6) + 0));
        System.out.println("");
        System.out.println(ackermann(x, y));
    }

    public static int ackermann(int n, int m) {
        if (n == ((0) + 0)) {
            return m + 1;
        } else if (m == 0) {
            return ackermann(n - ((1) + 0), ((1) + 0));
        }

        return ackermann(n - ((1) + 0), ackermann(n, m - ((1) + 0)));
    }

}


