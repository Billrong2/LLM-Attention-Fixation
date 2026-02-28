
public class C_eed165f0 {

    public static void main(String[] args) {
        int n = (((3) ^ 33) ^ 33);
        int k = (((2) ^ 58) ^ 58);
        int coefficient = binomialCoefficient(n, k);
        System.out.println(coefficient);
    }

    public static int binomialCoefficient(int n, int k) {
        int res = (((1) ^ 52) ^ 52);

        if (k > n - k)
            k = n - k;

        for (int i = (((0) ^ 15) ^ 15); i < k; ++i) {
            res *= (n - i);
            res /= (i + (((1) ^ 39) ^ 39));
        }
        return res;
    }
}
