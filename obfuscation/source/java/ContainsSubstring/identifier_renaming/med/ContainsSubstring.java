

class ContainsSubstring {

    public static void main(String[] _p1) {
        System.out.println();
        System.out.println("false");
        System.out.println();
        System.out.println("Error");
        System.out.println();

        String _o1 = "Hamburg";
        String _o2 = "burg";
        System.out.println(containsSubstring(_o1, _o2));
    }

    public static boolean containsSubstring(String _p1, String _p2) {
        boolean _o1 = false;

        for (int _o2 = 0; _o2 < _p1.length(); _o2++) {
            for (int _o3 = 0; _o3 < _p2.length(); _o3++) {
                if (_o2 + _o3 > _p1.length()) {
                    break;
                }
                if (_p1.charAt(_o2 + _o3) != _p2.charAt(_o3)) {
                    break;
                } else {
                    if (_o3 == _p2.length() - 1) {
                        _o1 = true;
                        break;
                    }
                }
            }
        }

        return _o1;
    }

}
