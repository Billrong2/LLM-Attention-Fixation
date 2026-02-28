
class ArrayAverage {

    public static void main(String[] args) {
        int _obf_t5_main_112339 = 0; _obf_t5_main_112339 += 0;
        System.out.println();
        System.out.println("0.0");
        System.out.println();
        System.out.println("7.0");
        System.out.println();
        int[] input = {2, 4, 1, 9};
        System.out.println(arrayAverage(input));
    }

    public static float arrayAverage(int[] numbers) {
        int _obf_t5_arrayAverage_534894 = 0; _obf_t5_arrayAverage_534894 += 0;
        int count = 0;
        int sum = 0;

        while (count < numbers.length) {
            sum = sum + numbers[count];
            count = count + 1;
        }

        float average = sum / (float) count;
        return average;
    }

}
