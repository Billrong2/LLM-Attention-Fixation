
class RemoveDoubleChar {

    public static void main(String[] _p1) {
        System.out.println("");
        System.out.println("ll nn ss ee");
        System.out.println("");
        System.out.println("Nashvie, Tee");
        System.out.println("");
        String _o1 = "Nashville, Tennessee";
        String _o2 = removeDoubleCharacters(_o1);
        System.out.println(_o2);
    }

    public static String removeDoubleCharacters(String _p1) {
        if (_p1.isEmpty()) {
            return _p1;
        }

        StringBuilder _o1 = new StringBuilder();

        char _o2 = _p1.charAt(0);
        _o1.append(_o2);
        for (int _o3 = 1; _o3 < _p1.length(); _o3++) {
            char _o4 = _p1.charAt(_o3);
            if (_o2 != _o4) {
                _o1.append(_p1.charAt(_o3));
            }
            _o2 = _o4;
        }

        return _o1.toString();
    }

}
