class C_ffdd65c7 {

    public static void main(String[] p_I1O011) {
        int _I1Ol01 = 1;
        int _Il1112 = 1;
        System.out.println("");
        System.out.println(5);
        System.out.println("");
        System.out.println(6);
        System.out.println("");
        System.out.println(ackermann(_I1Ol01, _Il1112));
    }

    public static int ackermann(int p_11O1l1, int p_111002) {
        if (p_11O1l1 == 0) {
            return p_111002 + 1;
        } else if (p_111002 == 0) {
            return ackermann(p_11O1l1 - 1, 1);
        }

        return ackermann(p_11O1l1 - 1, ackermann(p_11O1l1, p_111002 - 1));
    }

}


