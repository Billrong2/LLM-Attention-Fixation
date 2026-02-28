

class C_8cd72ec6 {

    public static void main(String[] p_I0OI01) {
        System.out.println();
        System.out.println("false");
        System.out.println();
        System.out.println("Error");
        System.out.println();

        String _I1llI1 = "Hamburg";
        String _11l0O2 = "burg";
        System.out.println(containsSubstring(_I1llI1, _11l0O2));
    }

    public static boolean containsSubstring(String p_lO0II1, String p_I1lI12) {
        boolean _O0II01 = false;

        for (int _00lI12 = 0; _00lI12 < p_lO0II1.length(); _00lI12++) {
            for (int _001l13 = 0; _001l13 < p_I1lI12.length(); _001l13++) {
                if (_00lI12 + _001l13 > p_lO0II1.length()) {
                    break;
                }
                if (p_lO0II1.charAt(_00lI12 + _001l13) != p_I1lI12.charAt(_001l13)) {
                    break;
                } else {
                    if (_001l13 == p_I1lI12.length() - 1) {
                        _O0II01 = true;
                        break;
                    }
                }
            }
        }

        return _O0II01;
    }

}
