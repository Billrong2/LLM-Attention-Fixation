
class LengthOfLast {

    public static void main(String[] _p1) {
        System.out.println();
        System.out.println("3");
        System.out.println();
        System.out.println("9");
        System.out.println();
        String _o1 = "The quick brown fox jumps";
        System.out.println(lengthOfLastWord(_o1));
    }


    public static int lengthOfLastWord(String _p1) {
        int _o1 = 0;
        boolean _o2 = false;
        for (int _o3 = _p1.length() - 1; _o3 >= 0; _o3--) {
            char _o4 = _p1.charAt(_o3);
            if ((_o4 >= 'a' && _o4 <= 'z') || (_o4 >= 'A' && _o4 <= 'Z')) {
                _o2 = true;
                _o1++;
            } else {
                if (_o2) {
                    break;
                }
            }
        }

        return _o1;
    }

}
