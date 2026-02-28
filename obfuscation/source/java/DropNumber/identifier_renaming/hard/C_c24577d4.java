class C_c24577d4 {

    public static void main(String[] p_0l0II1) {
        System.out.println("");
        System.out.println("1 3 4");
        System.out.println("");
        System.out.println("8 8 4");
        System.out.println("");
        int[] values = {8, 8, 1, 3, 4};
        int[] middle = dropNumber(values, 3);
        int[] out = dropNumber(middle, 1);

        for (int value : out) {
            System.out.print("" + value + " ");
        }
    }

    public static int[] dropNumber(int[] p_lI00I1, int p_l0l112) {
        if (p_lI00I1.length == 0 || p_l0l112 >= p_lI00I1.length) {
            throw new IllegalArgumentException();
        }

        int[] result = new int[p_lI00I1.length - 1];

        for (int _O1Ol01 = 0; _O1Ol01 < p_l0l112; _O1Ol01++) {
            result[_O1Ol01] = p_lI00I1[_O1Ol01];
        }

        for (int _O1Ol01 = p_l0l112; _O1Ol01 + 1 < p_lI00I1.length; _O1Ol01++) {
            result[_O1Ol01] = p_lI00I1[_O1Ol01 + 1];
        }

        return result;
    }
}
