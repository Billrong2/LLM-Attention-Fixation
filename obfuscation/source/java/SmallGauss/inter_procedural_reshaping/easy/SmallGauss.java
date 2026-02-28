
class SmallGauss {

    public static void main(String[] args) {
        _obf_t7_hook_main_465949();
        System.out.println(sum(10));
    }

    public static int sum(int n) {
        _obf_t7_hook_sum_600288();
        int res = 0;
        for (int i = 1; i < n; i++) {
            res += i;
        }
        return res;
    }


private static void _obf_t7_hook_sum_600288() {
        int _obf_t7_600288 = 0;
        _obf_t7_600288 += 0;
    }

    private static void _obf_t7_hook_main_465949() {
        int _obf_t7_465949 = 0;
        _obf_t7_465949 += 0;
    }
}
