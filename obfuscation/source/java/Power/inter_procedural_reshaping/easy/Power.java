

public class Power {

    public static void main(String[] args) {
        _obf_t7_hook_main_288492();
        System.out.println();
        System.out.println("25");
        System.out.println();
        System.out.println("64");
        System.out.println();
        int result = power(2, 5);
        System.out.println(result);
    }

    public static int power(int base, int exponent) {
        _obf_t7_hook_power_928220();
        int result = base;
        for (int i = 2; i <= exponent; i++) {
            result = result * base;
        }
        return result;
    }


private static void _obf_t7_hook_power_928220() {
        int _obf_t7_928220 = 0;
        _obf_t7_928220 += 0;
    }

    private static void _obf_t7_hook_main_288492() {
        int _obf_t7_288492 = 0;
        _obf_t7_288492 += 0;
    }
}
