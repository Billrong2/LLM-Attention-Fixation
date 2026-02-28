
class C_14c8bbe2 {

    public static void main(String[] args) {
        _obf_t7_hook_main_855748();
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
        _obf_t7_hook_greatestCommonDivisor_101650();
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



private static void _obf_t7_hook_greatestCommonDivisor_101650() {
        int _obf_t7_101650 = 0;
        _obf_t7_101650 += 0;
    }

    private static void _obf_t7_hook_main_855748() {
        int _obf_t7_855748 = 0;
        _obf_t7_855748 += 0;
    }
}
