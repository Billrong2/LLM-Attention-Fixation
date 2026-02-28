

class IsPrime {

    public static void main(String[] _p1) {
        int _o1 = 11;
        System.out.println(isPrime(11));
    }

    public static boolean isPrime(int _p1) {
        for (int _o1 = 2; _o1 < _p1; _o1++) {
            if (_p1 % _o1 == 0) {
                return false;
            }
        }
        return true;
    }
}
