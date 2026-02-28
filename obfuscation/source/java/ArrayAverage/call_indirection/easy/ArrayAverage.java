
class ArrayAverage {

    public static void main(String[] args) {
        System.out.println();
        System.out.println("0.0");
        System.out.println();
        System.out.println("7.0");
        System.out.println();
        int[] input = {2, 4, 1, 9};
        System.out.println(_obf_t8_arrayAverage_830160(input));
    }

    public static float arrayAverage(int[] numbers) {
        int _obf_t8_arrayAverage_610438 = 0; _obf_t8_arrayAverage_610438 += 0;
        int count = 0;
        int sum = 0;

        while (count < numbers.length) {
            sum = sum + numbers[count];
            count = count + 1;
        }

        float average = sum / (float) count;
        return average;
    }



private static float _obf_t8_arrayAverage_830160(int[] numbers) {
        return arrayAverage(numbers);
    }
}
