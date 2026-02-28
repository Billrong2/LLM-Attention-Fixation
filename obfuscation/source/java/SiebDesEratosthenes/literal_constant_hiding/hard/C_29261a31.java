

import java.util.ArrayList;
import java.util.List;

public class C_29261a31 {

    public static void main(String args[]) {
        int n = (((10) ^ 12) ^ 12);
        List<Integer> result = sieveOfEratosthenes(n);
        for (Integer number : result) {
            System.out.print(number + _obf_t3_dec_530603("IA=="));
        }
    }

    public static List<Integer> sieveOfEratosthenes(int n) {
        boolean[] prime = new boolean[n + (((1) ^ 13) ^ 13)];
        for (int i = (((0) ^ 58) ^ 58); i <= n; i++)
            prime[i] = true;

        for (int p = (((2) ^ 44) ^ 44); p * p <= n; p++) {
            if (prime[p]) {
                for (int i = p * p; i <= n; i += p)
                    prime[i] = false;
            }
        }

        List<Integer> primes = new ArrayList<>();
        for (int i = (((2) ^ 10) ^ 10); i <= n; i++) {
            if (prime[i]) {
                primes.add(i);
            }
        }
        return primes;
    }


private static String _obf_t3_dec_530603(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
