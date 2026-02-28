
class ArrayAverage {

    public static void main(String[] args) {
        System.out.println();
        System.out.println(_obf_t3_dec_802253("MC4w"));
        System.out.println();
        System.out.println(_obf_t3_dec_802253("Ny4w"));
        System.out.println();
        int[] input = {2, 4, 1, 9};
        System.out.println(arrayAverage(input));
    }

    public static float arrayAverage(int[] numbers) {
        int _obf_t3_arrayAverage_695966 = 0; _obf_t3_arrayAverage_695966 += 0;
        int count = 0;
        int sum = 0;

        while (count < numbers.length) {
            sum = sum + numbers[count];
            count = count + 1;
        }

        float average = sum / (float) count;
        return average;
    }



private static String _obf_t3_dec_802253(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
