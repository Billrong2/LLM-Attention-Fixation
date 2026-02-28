

import java.util.ArrayList;
import java.util.List;

public class C_bf4b1f91 {

    public static void main(String p_10ll01[]) {
        int _O0O0O1 = 10;
        List<Integer> _0O1OI2 = sieveOfEratosthenes(_O0O0O1);
        for (Integer number : _0O1OI2) {
            System.out.print(number + " ");
        }
    }

    public static List<Integer> sieveOfEratosthenes(int p_0OOOO1) {
        boolean[] prime = new boolean[p_0OOOO1 + 1];
        for (int _0I0Ol1 = 0; _0I0Ol1 <= p_0OOOO1; _0I0Ol1++)
            prime[_0I0Ol1] = true;

        for (int _00I0O2 = 2; _00I0O2 * _00I0O2 <= p_0OOOO1; _00I0O2++) {
            if (prime[_00I0O2]) {
                for (int _0I0Ol1 = _00I0O2 * _00I0O2; _0I0Ol1 <= p_0OOOO1; _0I0Ol1 += _00I0O2)
                    prime[_0I0Ol1] = false;
            }
        }

        List<Integer> _II0113 = new ArrayList<>();
        for (int _0I0Ol1 = 2; _0I0Ol1 <= p_0OOOO1; _0I0Ol1++) {
            if (prime[_0I0Ol1]) {
                _II0113.add(_0I0Ol1);
            }
        }
        return _II0113;
    }
}
