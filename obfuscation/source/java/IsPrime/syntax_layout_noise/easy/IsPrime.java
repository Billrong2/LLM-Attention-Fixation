

class IsPrime {

    public static void main(String[] args) {
        int _obf_t2_main_974169 = 0; _obf_t2_main_974169 += 0;
        int number = 11;
        System.out.println(isPrime(11));
    }

    public static boolean isPrime(int number) {
        for (int i = 2; i < number; i++) {
            if (number % i == 0) {
                return ((false));
            }
        }
        return ((true));
    }
}
