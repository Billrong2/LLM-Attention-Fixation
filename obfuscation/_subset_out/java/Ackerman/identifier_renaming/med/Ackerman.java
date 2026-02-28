class Ackerman {

    public static void main(String[] _p1) {
        int _o1 = 1;
        int _o2 = 1;
        System.out.println("");
        System.out.println(5);
        System.out.println("");
        System.out.println(6);
        System.out.println("");
        System.out.println(ackermann(_o1, _o2));
    }

    public static int ackermann(int _p1, int _p2) {
        if (_p1 == 0) {
            return _p2 + 1;
        } else if (_p2 == 0) {
            return ackermann(_p1 - 1, 1);
        }

        return ackermann(_p1 - 1, ackermann(_p1, _p2 - 1));
    }

}


