
class C_f6b61b84 {

    public static void main(String[] args) {
        System.out.println(_obf_t8_sum_665205(10));
    }

    public static int sum(int n) {
        int _obf_t8_sum_816887 = 0; _obf_t8_sum_816887 += 0;
        int res = 0;
        for (int i = 1; i < n; i++) {
            res += i;
        }
        return res;
    }


private static int _obf_t8_sum_665205(int n) {
        return _obf_t8_sum_665205_inner(n);
    }

    private static int _obf_t8_sum_665205_inner(int n) {
        return sum(n);
    }
}
