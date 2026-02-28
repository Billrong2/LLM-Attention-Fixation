
public class BinomialCoefficient {

    public static void main(String[] args) {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_main_405592 = 0;
            _obf_t5_main_405592++;
        }
        if (((2 * 2) + 1) > 0) {
            int _obf_t5_main_405592_m = 0;
            _obf_t5_main_405592_m += 0;
        } else {
            int _obf_t5_main_405592_e = 1;
            _obf_t5_main_405592_e -= 1;
        }
        int n = 3;
        int k = 2;
        int coefficient = binomialCoefficient(n, k);
        System.out.println(coefficient);
    }

    public static int binomialCoefficient(int n, int k) {
        int _obf_t5_binomialCoefficient_591095 = 0; _obf_t5_binomialCoefficient_591095 += 0;
        int res = 1;

        if (k > n - k)
            k = n - k;

        for (int i = 0; i < k; ++i) {
            res *= (n - i);
            res /= (i + 1);
        }
        return res;
    }
}
