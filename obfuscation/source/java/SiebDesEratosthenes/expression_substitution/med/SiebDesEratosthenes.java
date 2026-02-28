

import java.util.ArrayList;
import java.util.List;

public class SiebDesEratosthenes {

    public static void main(String args[]) {
        int _obf_t4_main_446393 = 0; _obf_t4_main_446393 += 0;
        int n = 10;
        List<Integer> result = sieveOfEratosthenes(n);
        for (Integer number : result) {
            System.out.print(number + " ");
        }
    }

    public static List<Integer> sieveOfEratosthenes(int n) {
        boolean[] prime = new boolean[n + 1];
        for (int i = (((0) ^ 28) ^ 28); i <= n; i++)
            prime[i] = true;

        for (int p = (((2) ^ 26) ^ 26); p * p <= n; p++) {
            if (prime[p]) {
                for (int i = p * p; i <= n; i += p)
                    prime[i] = (((((1) ^ 4) ^ 4) ^ (((0) ^ 19) ^ 19)) != (((1) ^ 29) ^ 29));
            }
        }

        List<Integer> primes = new ArrayList<>();
        for (int i = 2; i <= n; i++) {
            if (prime[i]) {
                primes.add(i);
            }
        }
        return primes;
    }
}
