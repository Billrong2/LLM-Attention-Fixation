

import java.util.ArrayList;
import java.util.List;

public class SiebDesEratosthenes {

    public static void main(String args[]) {
        _obf_t7_hook_main_16610();
        int n = 10;
        List<Integer> result = sieveOfEratosthenes(n);
        for (Integer number : result) {
            System.out.print(number + " ");
        }
    }

    public static List<Integer> sieveOfEratosthenes(int n) {
        _obf_t7_hook_sieveOfEratosthenes_15886();
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
        return primes;
    }


private static void _obf_t7_hook_sieveOfEratosthenes_15886() {
        int _obf_t7_15886 = 0;
        _obf_t7_15886 += 0;
    }

    private static void _obf_t7_hook_main_16610() {
        int _obf_t7_16610 = 0;
        _obf_t7_16610 += 0;
    }
}
