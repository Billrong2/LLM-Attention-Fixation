

import java.util.ArrayList;
import java.util.List;

public class C_5c6eb094 {

    public static void main(String args[]) {
            if (((2 * 2) == 4)) {
                int _obf_t2_299449 = 0;
                _obf_t2_299449 += 0;
            }
        int n = 10;
        List<Integer> result = sieveOfEratosthenes(n);
        for (Integer number : result) {
            System.out.print(number + " ");
        }
    }

    public static List<Integer> sieveOfEratosthenes(int n) {
            if (((2 * 2) == 4)) {
                int _obf_t2_460383 = 0;
                _obf_t2_460383 += 0;
            }
        boolean[] prime = new boolean[n + 1];
        for (int i = 0; i <= n; i++)
            prime[i] = true;

        for (int p = 2; p * p <= n; p++) {
            if (prime[p]) {
                for (int i = p * p; i <= n; i += p)
                    prime[i] = false;
            }
        }

        List<Integer> primes = new ArrayList<>();
        for (int i = 2; i <= n; i++) {
            if (prime[i]) {
                primes.add(i);
            }
        }
        return ((primes));
    }
}
