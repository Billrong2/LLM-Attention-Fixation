class Ackerman {

    public static void main(String[] args) {
        do {
            {
                int _obf_t6_easy_754097 = 0;
                _obf_t6_easy_754097 += 0;
                    int x = 1;
                    int y = 1;
                    System.out.println("");
                    System.out.println(5);
                    System.out.println("");
                    System.out.println(6);
                    System.out.println("");
                    System.out.println(ackermann(x, y));
                    
            }
        } while (false);
}

    public static int ackermann(int n, int m) {
        do {
            {
                int _obf_t6_easy_671998 = 0;
                _obf_t6_easy_671998 += 0;
                    if (n == 0) {
                    return m + 1;
                    } else if (m == 0) {
                    return ackermann(n - 1, 1);
                    }
                    
                    return ackermann(n - 1, ackermann(n, m - 1));
                    
            }
        } while (false);
}

}


