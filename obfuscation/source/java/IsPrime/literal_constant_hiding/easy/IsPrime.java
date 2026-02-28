

class IsPrime {

    public static void main(String[] args) {
        int _obf_t3_main_299547 = 0; _obf_t3_main_299547 += 0;
        int number = 11;
        System.out.println(isPrime(11));
    }

    public static boolean isPrime(int number) {
        int _obf_t3_isPrime_317633 = 0; _obf_t3_isPrime_317633 += 0;
        for (int i = 2; i < number; i++) {
            if (number % i == 0) {
                return false;
            }
        }
        return true;
    }
}
