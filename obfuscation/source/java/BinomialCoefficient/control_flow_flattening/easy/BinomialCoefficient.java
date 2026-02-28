
public class BinomialCoefficient {

    public static void main(String[] args) {
        do {
            {
                int _obf_t6_easy_641621 = 0;
                _obf_t6_easy_641621 += 0;
                    int n = 3;
                    int k = 2;
                    int coefficient = binomialCoefficient(n, k);
                    System.out.println(coefficient);
                    
            }
        } while (false);
}

    public static int binomialCoefficient(int n, int k) {
        do {
            {
                int _obf_t6_easy_839347 = 0;
                _obf_t6_easy_839347 += 0;
                    int res = 1;
                    
                    if (k > n - k)
                    k = n - k;
                    
                    for (int i = 0; i < k; ++i) {
                    res *= (n - i);
                    res /= (i + 1);
                    }
                    return res;
                    
            }
        } while (false);
}
}
