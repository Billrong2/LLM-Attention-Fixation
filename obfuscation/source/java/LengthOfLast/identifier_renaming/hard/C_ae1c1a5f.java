
class C_ae1c1a5f {

    public static void main(String[] p_lOO0l1) {
        System.out.println();
        System.out.println("3");
        System.out.println();
        System.out.println("9");
        System.out.println();
        String _0lO1l1 = "The quick brown fox jumps";
        System.out.println(lengthOfLastWord(_0lO1l1));
    }


    public static int lengthOfLastWord(String p_IOI1l1) {
        int _lIO111 = 0;
        boolean _1lO1I2 = false;
        for (int _llOI03 = p_IOI1l1.length() - 1; _llOI03 >= 0; _llOI03--) {
            char _OIl1O4 = p_IOI1l1.charAt(_llOI03);
            if ((_OIl1O4 >= 'a' && _OIl1O4 <= 'z') || (_OIl1O4 >= 'A' && _OIl1O4 <= 'Z')) {
                _1lO1I2 = true;
                _lIO111++;
            } else {
                if (_1lO1I2) {
                    break;
                }
            }
        }

        return _lIO111;
    }

}
