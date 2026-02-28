

public class Power {

    public static void main(String[] args) {
        int _obf_t5_main_318186 = 0; _obf_t5_main_318186 += 0;
        System.out.println();
        System.out.println("25");
        System.out.println();
        System.out.println("64");
        System.out.println();
        int result = power(2, 5);
        System.out.println(result);
    }

    public static int power(int base, int exponent) {
        int _obf_t5_power_22937 = 0; _obf_t5_power_22937 += 0;
        int result = base;
        for (int i = 2; i <= exponent; i++) {
            result = result * base;
        }
        return result;
    }
}
