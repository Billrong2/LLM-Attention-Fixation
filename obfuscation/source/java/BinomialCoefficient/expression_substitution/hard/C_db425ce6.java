
public class C_db425ce6 {

    public static void main(String[] args) {
        int n = ((((3) ^ 12) ^ 12) + 0);
        int k = ((((2) ^ 29) ^ 29) + 0);
        int coefficient = binomialCoefficient(n, k);
        System.out.println(coefficient);
    }

    public static int binomialCoefficient(int n, int k) {
        int res = 1;

        if (k > n - k)
            k = n - k;

        for (int i = ((((0) ^ 33) ^ 33) + 0); i < k; ++i) {
            res *= (n - i);
            res /= (i + 1);
        }
        return res;
    }
}
