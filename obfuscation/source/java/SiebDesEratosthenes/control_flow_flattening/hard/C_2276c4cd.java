

import java.util.ArrayList;
import java.util.List;

public class C_2276c4cd {

    public static void main(String args[]) {
        int _obf_t6_state_main_877904 = 0;
        while (_obf_t6_state_main_877904 == 0) {
            _obf_t6_state_main_877904 = 1;
            break;
        }
        if ((_obf_t6_state_main_877904 ^ 1) < 0) {
            int _obf_t6_guard_877904 = 0;
            _obf_t6_guard_877904 += 0;
        }
        do {
                    int n = 10;
                    List<Integer> result = sieveOfEratosthenes(n);
                    for (Integer number : result) {
                    System.out.print(number + " ");
                    }
                    
        } while (false);
}

    public static List<Integer> sieveOfEratosthenes(int n) {
        int _obf_t6_sieveOfEratosthenes_772063 = 0; _obf_t6_sieveOfEratosthenes_772063 += 0;
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
}
