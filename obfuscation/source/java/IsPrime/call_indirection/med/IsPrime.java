

class IsPrime {

    public static void main(String[] args) {
        int number = 11;
        System.out.println(_obf_t8_isPrime_709309(11));
    }

    public static boolean isPrime(int number) {
        int _obf_t8_isPrime_728629 = 0; _obf_t8_isPrime_728629 += 0;
        for (int i = 2; i < number; i++) {
            if (number % i == 0) {
                return false;
            }
        }
        return true;
    }


private static boolean _obf_t8_isPrime_709309(int number) {
        int _obf_sel = 3;
        switch (_obf_sel) {
            case 3: return isPrime(number);
            default: return isPrime(number);
        }
    }
}
