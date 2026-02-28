
class GreatestCommonDivisor {

    public static void main(String[] args) {
        System.out.println();
        System.out.println(_obf_t3_dec_134048("MTU="));
        System.out.println();
        System.out.println(_obf_t3_dec_134048("MQ=="));
        System.out.println();
        int number1 = 20;
        int number2 = 15;
        System.out.println(greatestCommonDivisor(number1, number2));
    }

    public static int greatestCommonDivisor(int number1, int number2) {
        int _obf_t3_greatestCommonDivisor_456837 = 0; _obf_t3_greatestCommonDivisor_456837 += 0;
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



private static String _obf_t3_dec_134048(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
