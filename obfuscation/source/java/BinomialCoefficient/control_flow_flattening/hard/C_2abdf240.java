
public class C_2abdf240 {

    public static void main(String[] args) {
        int _obf_t6_main_385212 = 0; _obf_t6_main_385212 += 0;
        int n = 3;
        int k = 2;
        int coefficient = binomialCoefficient(n, k);
        System.out.println(coefficient);
    }

    public static int binomialCoefficient(int n, int k) {
        int _obf_t6_state_binomialCoefficient_839347 = 0;
        while (_obf_t6_state_binomialCoefficient_839347 == 0) {
            _obf_t6_state_binomialCoefficient_839347 = 1;
            break;
        }
        if ((_obf_t6_state_binomialCoefficient_839347 ^ 1) < 0) {
            int _obf_t6_guard_839347 = 0;
            _obf_t6_guard_839347 += 0;
        }
        do {
                    int res = 1;
                    
                    if (k > n - k)
                    k = n - k;
                    
                    for (int i = 0; i < k; ++i) {
                    res *= (n - i);
                    res /= (i + 1);
                    }
                    return res;
                    
        } while (false);
}
}
