

public class IsAnagram {

    public static void main(String[] _p1) {
        System.out.println(isAnagram("keep", "peek"));
    }

    public static String sort(String _p1) {
        StringBuilder _o1 = new StringBuilder(_p1);
        for (int _o2 = 1; _o2 < _o1.length(); _o2++) {
            char _o3 = _o1.charAt(_o2);
            int _o4 = _o2;
            while (_o4 > 0 && _o1.charAt(_o4 - 1) > _o3) {
                _o1.setCharAt(_o4, _o1.charAt(_o4 - 1));
                _o4--;
            }
            _o1.setCharAt(_o4, _o3);
        }
        return _o1.toString();
    }

    public static boolean isAnagram(String _p1, String _p2) {
        if (_p1.length() != _p2.length()) {
            return false;
        }
        _p1 = sort(_p1);
        _p2 = sort(_p2);

        for (int _o1 = 0; _o1 < _p1.length(); _o1++) {
            if (_p1.charAt(_o1) != _p2.charAt(_o1)) {
                return false;
            }
        }
        return true;
    }
}
