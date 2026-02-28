
class ArrayAverage {

    public static void main(String[] args) {
        do {
            {
                int _obf_t6_easy_204089 = 0;
                _obf_t6_easy_204089 += 0;
                    System.out.println();
                    System.out.println("0.0");
                    System.out.println();
                    System.out.println("7.0");
                    System.out.println();
                    int[] input = {2, 4, 1, 9};
                    System.out.println(arrayAverage(input));
                    
            }
        } while (false);
}

    public static float arrayAverage(int[] numbers) {
        do {
            {
                int _obf_t6_easy_587281 = 0;
                _obf_t6_easy_587281 += 0;
                    int count = 0;
                    int sum = 0;
                    
                    while (count < numbers.length) {
                    sum = sum + numbers[count];
                    count = count + 1;
                    }
                    
                    float average = sum / (float) count;
                    return average;
                    
            }
        } while (false);
}

}
