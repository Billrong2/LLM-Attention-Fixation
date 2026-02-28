
class C_ce84887d {

    public static void main(String[] args) {
        System.out.println();
        System.out.println("0.0");
        System.out.println();
        System.out.println("7.0");
        System.out.println();
        int[] input = {((((2) ^ 56) ^ 56) + 0), ((((4) ^ 44) ^ 44) + 0), ((((1) ^ 16) ^ 16) + 0), 9};
        System.out.println(arrayAverage(input));
    }

    public static float arrayAverage(int[] numbers) {
        int count = ((((0) ^ 2) ^ 2) + 0);
        int sum = ((((0) ^ 17) ^ 17) + 0);

        while (count < numbers.length) {
            sum = sum + numbers[count];
            count = count + ((((1) ^ 20) ^ 20) + 0);
        }

        float average = sum / (float) count;
        return average;
    }

}
