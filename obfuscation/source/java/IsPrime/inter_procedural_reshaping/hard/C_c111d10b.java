

class C_c111d10b {

    public static void main(String[] args) {
        _obf_t7_hook_main_915675();
        int number = 11;
        System.out.println(isPrime(11));
    }

    public static boolean isPrime(int number) {
        _obf_t7_hook_isPrime_748524();
        for (int i = 2; i < number; i++) {
            if (number % i == 0) {
                return false;
            }
        }
        return true;
    }


private static void _obf_t7_hook_isPrime_748524() {
        int _obf_t7_748524 = 0;
        _obf_t7_748524 += 0;
    }

    private static void _obf_t7_hook_main_915675() {
        int _obf_t7_915675 = 0;
        _obf_t7_915675 += 0;
    }
}
