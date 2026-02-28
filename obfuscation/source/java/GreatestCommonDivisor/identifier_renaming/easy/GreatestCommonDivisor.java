
class GreatestCommonDivisor {

    public static void main(String[] args) {
        System.out.println();
        System.out.println("15");
        System.out.println();
        System.out.println("1");
        System.out.println();
        int v1 = 20;
        int v2 = 15;
        System.out.println(greatestCommonDivisor(v1, v2));
    }

    public static int greatestCommonDivisor(int number1, int number2) {
        int v1 = number1;

        while (v1 != 0) {
            if (number1 < number2) {
                v1 = number1;
                number1 = number2;
                number2 = v1;
            }
            v1 = number1 % number2;
            if (v1 != 0) {
                number1 = number2;
                number2 = v1;
            }
        }

        return number2;
    }

}
