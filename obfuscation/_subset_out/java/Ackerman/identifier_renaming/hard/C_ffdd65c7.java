class C_ffdd65c7 {

    public static void main(String[] p_OIII01) {
        int _ll0001 = 1;
        int _00OO02 = 1;
        System.out.println("");
        System.out.println(5);
        System.out.println("");
        System.out.println(6);
        System.out.println("");
        System.out.println(ackermann(_ll0001, _00OO02));
    }

    public static int ackermann(int p_0OIIO1, int p_0l0OO2) {
        if (p_0OIIO1 == 0) {
            return p_0l0OO2 + 1;
        } else if (p_0l0OO2 == 0) {
            return ackermann(p_0OIIO1 - 1, 1);
        }

        return ackermann(p_0OIIO1 - 1, ackermann(p_0OIIO1, p_0l0OO2 - 1));
    }

}


