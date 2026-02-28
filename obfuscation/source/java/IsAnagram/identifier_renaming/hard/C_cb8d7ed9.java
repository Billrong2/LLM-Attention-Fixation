

public class C_cb8d7ed9 {

    public static void main(String[] p_OOlOl1) {
        System.out.println(isAnagram("keep", "peek"));
    }

    public static String sort(String p_10l111) {
        StringBuilder _OOl1I1 = new StringBuilder(p_10l111);
        for (int _1l0I12 = 1; _1l0I12 < _OOl1I1.length(); _1l0I12++) {
            char _000I13 = _OOl1I1.charAt(_1l0I12);
            int _I0OlI4 = _1l0I12;
            while (_I0OlI4 > 0 && _OOl1I1.charAt(_I0OlI4 - 1) > _000I13) {
                _OOl1I1.setCharAt(_I0OlI4, _OOl1I1.charAt(_I0OlI4 - 1));
                _I0OlI4--;
            }
            _OOl1I1.setCharAt(_I0OlI4, _000I13);
        }
        return _OOl1I1.toString();
    }

    public static boolean isAnagram(String p_000l01, String p_01IIO2) {
        if (p_000l01.length() != p_01IIO2.length()) {
            return false;
        }
        p_000l01 = sort(p_000l01);
        p_01IIO2 = sort(p_01IIO2);

        for (int _1OlIO1 = 0; _1OlIO1 < p_000l01.length(); _1OlIO1++) {
            if (p_000l01.charAt(_1OlIO1) != p_01IIO2.charAt(_1OlIO1)) {
                return false;
            }
        }
        return true;
    }
}
