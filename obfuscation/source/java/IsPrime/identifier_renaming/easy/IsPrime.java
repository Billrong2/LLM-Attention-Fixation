

class IsPrime {

    public static void main(String[] args) {
        int v1 = 11;
        System.out.println(isPrime(11));
    }

    public static boolean isPrime(int number) {
        for (int v1 = 2; v1 < number; v1++) {
            if (number % v1 == 0) {
                return false;
            }
        }
        return true;
    }
}
