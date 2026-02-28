

import java.util.ArrayList;
import java.util.List;

public class SiebDesEratosthenes {

    public static void main(String args[]) {
        int v1 = 10;
        List<Integer> v2 = sieveOfEratosthenes(v1);
        for (Integer number : v2) {
            System.out.print(number + " ");
        }
    }

    public static List<Integer> sieveOfEratosthenes(int n) {
        boolean[] prime = new boolean[n + 1];
        for (int v1 = 0; v1 <= n; v1++)
            prime[v1] = true;

        for (int v2 = 2; v2 * v2 <= n; v2++) {
            if (prime[v2]) {
                for (int v1 = v2 * v2; v1 <= n; v1 += v2)
                    prime[v1] = false;
            }
        }

        List<Integer> v3 = new ArrayList<>();
        for (int v1 = 2; v1 <= n; v1++) {
            if (prime[v1]) {
                v3.add(v1);
            }
        }
        return v3;
    }
}
