
public class BinomialCoefficient {

    public static void main(String[] args) {
        int v1 = 3;
        int v2 = 2;
        int v3 = binomialCoefficient(v1, v2);
        System.out.println(v3);
    }

    public static int binomialCoefficient(int n, int k) {
        int v1 = 1;

        if (k > n - k)
            k = n - k;

        for (int v2 = 0; v2 < k; ++v2) {
            v1 *= (n - v2);
            v1 /= (v2 + 1);
        }
        return v1;
    }
}
