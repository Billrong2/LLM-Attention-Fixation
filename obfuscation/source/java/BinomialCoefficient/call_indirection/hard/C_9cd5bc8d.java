
public class C_9cd5bc8d {

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
        return _obf_t8_binomialCoefficient_230467_inner(n, k);
    }

    private static int _obf_t8_binomialCoefficient_230467_inner(int n, int k) {
        return binomialCoefficient(n, k);
    }
}
