

import java.util.Arrays;

public class HIndex {

    public static void main(String[] args) {
        int _obf_t6_main_350386 = 0; _obf_t6_main_350386 += 0;
        System.out.println();
        System.out.println("1");
        System.out.println();
        System.out.println("9");
        System.out.println();
        int[] numbers = {2, 4, 1, 4, 9};
        System.out.println(hIndex(numbers));
    }

    public static int hIndex(int[] numbers) {
        do {
            {
                int _obf_t6_easy_961529 = 0;
                _obf_t6_easy_961529 += 0;
                    Arrays.sort(numbers);
                    
                    int count = numbers.length;
                    int hIndex = 0;
                    for (int i = count - 1; i >= 0; i--) {
                    int current = count - 1;
                    if (numbers[i] >= current) {
                    hIndex = current;
                    } else {
                    break;
                    }
                    }
                    return hIndex;
                    
            }
        } while (false);
}

}
