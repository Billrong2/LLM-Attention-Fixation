

public class Power {

    public static void main(String[] args) {
        System.out.println();
        System.out.println("25");
        System.out.println();
        System.out.println("64");
        System.out.println();
        int result = power(2, (((5) ^ 15) ^ 15));
        System.out.println(result);
    }

    public static int power(int base, int exponent) {
        int result = base;
        for (int i = (((2) ^ 26) ^ 26); i <= exponent; i++) {
            result = result * base;
        }
        return result;
    }
}
