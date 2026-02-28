
class ArrayAverage {

    public static void main(String[] args) {
        _obf_t7_hook_main_993284();
        System.out.println();
        System.out.println("0.0");
        System.out.println();
        System.out.println("7.0");
        System.out.println();
        int[] input = {2, 4, 1, 9};
        System.out.println(arrayAverage(input));
    }

    public static float arrayAverage(int[] numbers) {
        _obf_t7_hook_arrayAverage_756947();
        int count = 0;
        int sum = 0;

        while (count < numbers.length) {
            sum = sum + numbers[count];
            count = count + 1;
        }

        float average = sum / (float) count;
        return average;
    }



private static void _obf_t7_hook_arrayAverage_756947() {
        int _obf_t7_756947 = 0;
        _obf_t7_756947 += 0;
    }

    private static void _obf_t7_hook_main_993284() {
        int _obf_t7_993284 = 0;
        _obf_t7_993284 += 0;
    }
}
