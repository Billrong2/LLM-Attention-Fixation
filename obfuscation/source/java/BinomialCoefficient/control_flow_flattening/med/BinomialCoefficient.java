
public class BinomialCoefficient {

    public static void main(String[] args) {
        int _obf_t6_state_main_641621 = 0;
        while (_obf_t6_state_main_641621 == 0) {
            _obf_t6_state_main_641621 = 1;
            break;
        }
        do {
                    int n = 3;
                    int k = 2;
                    int coefficient = binomialCoefficient(n, k);
                    System.out.println(coefficient);
                    
        } while (false);
}

    public static int binomialCoefficient(int n, int k) {
        int _obf_t6_state_binomialCoefficient_839347 = 0;
        while (_obf_t6_state_binomialCoefficient_839347 == 0) {
            _obf_t6_state_binomialCoefficient_839347 = 1;
            break;
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
