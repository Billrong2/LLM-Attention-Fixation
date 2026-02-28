
class C_9577bbb0 {

    public static void main(String[] p_1IO1O1) {
        System.out.println();
        System.out.println("0.0");
        System.out.println();
        System.out.println("7.0");
        System.out.println();
        int[] input = {2, 4, 1, 9};
        System.out.println(arrayAverage(input));
    }

    public static float arrayAverage(int[] p_OIOOI1) {
        int _01O111 = 0;
        int _O11OI2 = 0;

        while (_01O111 < p_OIOOI1.length) {
            _O11OI2 = _O11OI2 + p_OIOOI1[_01O111];
            _01O111 = _01O111 + 1;
        }

        float _0I0ll3 = _O11OI2 / (float) _01O111;
        return _0I0ll3;
    }

}
