
public class BinomialCoefficient {

    public static void main(String[] args) {
        _obf_t7_hook_main_54890();
        int n = 3;
        int k = 2;
        int coefficient = binomialCoefficient(n, k);
        System.out.println(coefficient);
    }

    public static int binomialCoefficient(int n, int k) {
        _obf_t7_hook_binomialCoefficient_975999();
        int res = 1;

        if (k > n - k)
            k = n - k;

        for (int i = 0; i < k; ++i) {
            res *= (n - i);
            res /= (i + 1);
        }
        return res;
    }


private static void _obf_t7_hook_binomialCoefficient_975999() {
        int _obf_t7_975999 = 0;
        _obf_t7_975999 += 0;
    }

    private static void _obf_t7_hook_main_54890() {
        int _obf_t7_54890 = 0;
        _obf_t7_54890 += 0;
    }
}
