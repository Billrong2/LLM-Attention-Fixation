
class ArrayAverage {

    public static void main(String[] args) {
        System.out.println();
        System.out.println("0.0");
        System.out.println();
        System.out.println("7.0");
        System.out.println();
        int[] input = {(((2) ^ 29) ^ 29), (((4) ^ 23) ^ 23), (((1) ^ 9) ^ 9), (((9) ^ 13) ^ 13)};
        System.out.println(arrayAverage(input));
    }

    public static float arrayAverage(int[] numbers) {
        int count = (((0) ^ 2) ^ 2);
        int sum = (((0) ^ 9) ^ 9);

        while (count < numbers.length) {
            sum = sum + numbers[count];
            count = count + (((1) ^ 11) ^ 11);
        }

        float average = sum / (float) count;
        return average;
    }

}
