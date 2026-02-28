
class C_ad0e263c {

    public static void main(String[] p_lI1OI1) {
        System.out.println("");
        System.out.println("ll nn ss ee");
        System.out.println("");
        System.out.println("Nashvie, Tee");
        System.out.println("");
        String _ll1001 = "Nashville, Tennessee";
        String _110II2 = removeDoubleCharacters(_ll1001);
        System.out.println(_110II2);
    }

    public static String removeDoubleCharacters(String p_1IIO11) {
        if (p_1IIO11.isEmpty()) {
            return p_1IIO11;
        }

        StringBuilder _0lll11 = new StringBuilder();

        char _I1II02 = p_1IIO11.charAt(0);
        _0lll11.append(_I1II02);
        for (int _10Ol13 = 1; _10Ol13 < p_1IIO11.length(); _10Ol13++) {
            char _lO1O14 = p_1IIO11.charAt(_10Ol13);
            if (_I1II02 != _lO1O14) {
                _0lll11.append(p_1IIO11.charAt(_10Ol13));
            }
            _I1II02 = _lO1O14;
        }

        return _0lll11.toString();
    }

}
