
public class C_05d4ff5b {

    public static void main(String[] p_0I0ll1) {
        int _lI0111 = 3;
        int _10I1O2 = 2;
        int _lI1003 = binomialCoefficient(_lI0111, _10I1O2);
        System.out.println(_lI1003);
    }

    public static int binomialCoefficient(int p_O1ll11, int p_l0lIO2) {
        int _l0lll1 = 1;

        if (p_l0lIO2 > p_O1ll11 - p_l0lIO2)
            p_l0lIO2 = p_O1ll11 - p_l0lIO2;

        for (int _O0I0I2 = 0; _O0I0I2 < p_l0lIO2; ++_O0I0I2) {
            _l0lll1 *= (p_O1ll11 - _O0I0I2);
            _l0lll1 /= (_O0I0I2 + 1);
        }
        return _l0lll1;
    }
}
