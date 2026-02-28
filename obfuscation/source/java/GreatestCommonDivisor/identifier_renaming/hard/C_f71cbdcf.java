
class C_f71cbdcf {

    public static void main(String[] p_00O1l1) {
        System.out.println();
        System.out.println("15");
        System.out.println();
        System.out.println("1");
        System.out.println();
        int _OIIll1 = 20;
        int _O0II02 = 15;
        System.out.println(greatestCommonDivisor(_OIIll1, _O0II02));
    }

    public static int greatestCommonDivisor(int p_O01l01, int p_1IIll2) {
        int _II01l1 = p_O01l01;

        while (_II01l1 != 0) {
            if (p_O01l01 < p_1IIll2) {
                _II01l1 = p_O01l01;
                p_O01l01 = p_1IIll2;
                p_1IIll2 = _II01l1;
            }
            _II01l1 = p_O01l01 % p_1IIll2;
            if (_II01l1 != 0) {
                p_O01l01 = p_1IIll2;
                p_1IIll2 = _II01l1;
            }
        }

        return p_1IIll2;
    }

}
