

class C_34b4db5e {

    public static void main(String[] p_IIOOI1) {
        int _1l0O11 = 11;
        System.out.println(isPrime(11));
    }

    public static boolean isPrime(int p_1IIIO1) {
        for (int _OIlOO1 = 2; _OIlOO1 < p_1IIIO1; _OIlOO1++) {
            if (p_1IIIO1 % _OIlOO1 == 0) {
                return false;
            }
        }
        return true;
    }
}
