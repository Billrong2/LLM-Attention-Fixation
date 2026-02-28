
class C_3eaf1887 {
    public static void main(String[] p_I00O01) {
        int[] array = {1, 6, 4, 16, 2};
        reverse(array);

        for (int i : array)
            System.out.print(i + " ");
    }

    public static void reverse(int[] p_l1OII1) {
        for (int _l1OIl1 = 0; _l1OIl1 <= p_l1OII1.length / 2 - 1; _l1OIl1++) {
            int _Il1lO2 = p_l1OII1[p_l1OII1.length - 1 - _l1OIl1];
            p_l1OII1[p_l1OII1.length - _l1OIl1 - 1] = p_l1OII1[_l1OIl1];
            p_l1OII1[_l1OIl1] = _Il1lO2;
        }
    }
}
