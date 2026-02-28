
public class BinomialCoefficient {

    public static void main(String[] args) {
        int n = 3;
        int k = 2;
        int coefficient = _obf_t8_binomialCoefficient_230467(n, k);
        System.out.println(coefficient);
    }

    public static int binomialCoefficient(int n, int k) {
        int _obf_t8_binomialCoefficient_271246 = 0; _obf_t8_binomialCoefficient_271246 += 0;
        int res = 1;

        if (k > n - k)
            k = n - k;

        for (int i = 0; i < k; ++i) {
            res *= (n - i);
            res /= (i + 1);
        }
        return res;
    }


private static int _obf_t8_binomialCoefficient_230467(int n, int k) {
        int _obf_sel = 1;
        switch (_obf_sel) {
            case 1: return binomialCoefficient(n, k);
            default: return binomialCoefficient(n, k);
        }
    }
}
