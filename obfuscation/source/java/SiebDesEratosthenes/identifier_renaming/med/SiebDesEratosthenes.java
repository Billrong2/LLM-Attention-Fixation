

import java.util.ArrayList;
import java.util.List;

public class SiebDesEratosthenes {

    public static void main(String _p1[]) {
        int _o1 = 10;
        List<Integer> _o2 = sieveOfEratosthenes(_o1);
        for (Integer number : _o2) {
            System.out.print(number + " ");
        }
    }

    public static List<Integer> sieveOfEratosthenes(int _p1) {
        boolean[] prime = new boolean[_p1 + 1];
        for (int _o1 = 0; _o1 <= _p1; _o1++)
            prime[_o1] = true;

        for (int _o2 = 2; _o2 * _o2 <= _p1; _o2++) {
            if (prime[_o2]) {
                for (int _o1 = _o2 * _o2; _o1 <= _p1; _o1 += _o2)
                    prime[_o1] = false;
            }
        }

        List<Integer> _o3 = new ArrayList<>();
        for (int _o1 = 2; _o1 <= _p1; _o1++) {
            if (prime[_o1]) {
                _o3.add(_o1);
            }
        }
        return _o3;
    }
}
