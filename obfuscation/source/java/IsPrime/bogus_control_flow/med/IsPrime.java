

class IsPrime {

    public static void main(String[] args) {
        int _obf_t5_main_188457 = 0; _obf_t5_main_188457 += 0;
        int number = 11;
        System.out.println(isPrime(11));
    }

    public static boolean isPrime(int number) {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_isPrime_923453 = 0;
            _obf_t5_isPrime_923453++;
        }
        if (((2 * 2) + 1) > 0) {
            int _obf_t5_isPrime_923453_m = 0;
            _obf_t5_isPrime_923453_m += 0;
        } else {
            int _obf_t5_isPrime_923453_e = 1;
            _obf_t5_isPrime_923453_e -= 1;
        }
        for (int i = 2; i < number; i++) {
            if (number % i == 0) {
                return false;
            }
        }
        return true;
    }
}
