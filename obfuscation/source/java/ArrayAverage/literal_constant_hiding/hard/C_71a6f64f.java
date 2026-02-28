
class C_71a6f64f {

    public static void main(String[] args) {
        System.out.println();
        System.out.println(_obf_t3_dec_802253("MC4w"));
        System.out.println();
        System.out.println(_obf_t3_dec_802253("Ny4w"));
        System.out.println();
        int[] input = {(((2) ^ 48) ^ 48), (((4) ^ 3) ^ 3), (((1) ^ 13) ^ 13), (((9) ^ 29) ^ 29)};
        System.out.println(arrayAverage(input));
    }

    public static float arrayAverage(int[] numbers) {
        int count = (((0) ^ 26) ^ 26);
        int sum = (((0) ^ 5) ^ 5);

        while (count < numbers.length) {
            sum = sum + numbers[count];
            count = count + (((1) ^ 17) ^ 17);
        }

        float average = sum / (float) count;
        return average;
    }



private static String _obf_t3_dec_802253(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
