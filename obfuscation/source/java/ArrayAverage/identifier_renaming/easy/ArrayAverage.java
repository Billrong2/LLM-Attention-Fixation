
class ArrayAverage {

    public static void main(String[] args) {
        int _obf_t1_main_77818 = 0; _obf_t1_main_77818 += 0;
        System.out.println();
        System.out.println("0.0");
        System.out.println();
        System.out.println("7.0");
        System.out.println();
        int[] input = {2, 4, 1, 9};
        System.out.println(arrayAverage(input));
    }

    public static float arrayAverage(int[] numbers) {
        int v1 = 0;
        int v2 = 0;

        while (v1 < numbers.length) {
            v2 = v2 + numbers[v1];
            v1 = v1 + 1;
        }

        float v3 = v2 / (float) v1;
        return v3;
    }

}
