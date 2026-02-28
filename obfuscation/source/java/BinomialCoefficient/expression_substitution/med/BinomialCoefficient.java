
public class BinomialCoefficient {

    public static void main(String[] args) {
        int n = (((3) ^ 7) ^ 7);
        int k = (((2) ^ 15) ^ 15);
        int coefficient = binomialCoefficient(n, k);
        System.out.println(coefficient);
    }

    public static int binomialCoefficient(int n, int k) {
        int res = (((1) ^ 15) ^ 15);

        if (k > n - k)
            k = n - k;

        for (int i = 0; i < k; ++i) {
            res *= (n - i);
            res /= (i + 1);
        }
        return res;
    }
}
