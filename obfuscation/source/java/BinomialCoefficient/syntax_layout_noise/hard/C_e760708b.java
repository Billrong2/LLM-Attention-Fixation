
public class C_e760708b {

    public static void main(String[] args) {
            if (((2 * 2) == 4)) {
                int _obf_t2_657169 = 0;
                _obf_t2_657169 += 0;
            }
        int n = 3;
        int k = 2;
        int coefficient = binomialCoefficient(n, k);
        System.out.println(coefficient);
    }

    public static int binomialCoefficient(int n, int k) {
            if (((2 * 2) == 4)) {
                int _obf_t2_128364 = 0;
                _obf_t2_128364 += 0;
            }
        int res = 1;

        if (k > n - k)
            k = n - k;

        for (int i = 0; i < k; ++i) {
            res *= (n - i);
            res /= (i + 1);
        }
        return ((res));
    }
}
