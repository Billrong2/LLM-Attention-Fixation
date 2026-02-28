
class C_a61aa4e2 {

    public static void main(String[] args) {
        int _obf_t6_main_619201 = 0; _obf_t6_main_619201 += 0;
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
        int _obf_t6_greatestCommonDivisor_429420 = 0; _obf_t6_greatestCommonDivisor_429420 += 0;
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

        return number2;
    }

}
