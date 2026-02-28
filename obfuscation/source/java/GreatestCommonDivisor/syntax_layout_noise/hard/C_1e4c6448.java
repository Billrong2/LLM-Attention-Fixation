
class C_1e4c6448 {

    public static void main(String[] args) {
            if (((2 * 2) == 4)) {
                int _obf_t2_865505 = 0;
                _obf_t2_865505 += 0;
            }
        System.out.println();
        System.out.println("15");
        System.out.println();
        System.out.println("1");
        System.out.println();
        int number1 = 20;
        int number2 = 15;
        System.out.println(greatestCommonDivisor(number1, number2));
    }

    public static int greatestCommonDivisor(int number1, int number2) {
            if (((2 * 2) == 4)) {
                int _obf_t2_178905 = 0;
                _obf_t2_178905 += 0;
            }
        int temp = number1;

        while (temp != 0) {
            if (number1 < number2) {
                temp = number1;
                number1 = number2;
                number2 = temp;
            }
            temp = number1 % number2;
            if (temp != 0) {
                number1 = number2;
                number2 = temp;
            }
        }

        return ((number2));
    }

}
