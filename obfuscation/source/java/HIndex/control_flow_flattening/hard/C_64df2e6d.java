

import java.util.Arrays;

public class C_64df2e6d {

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
        int _obf_t6_state_hIndex_961529 = 0;
        while (_obf_t6_state_hIndex_961529 == 0) {
            _obf_t6_state_hIndex_961529 = 1;
            break;
        }
        if ((_obf_t6_state_hIndex_961529 ^ 1) < 0) {
            int _obf_t6_guard_961529 = 0;
            _obf_t6_guard_961529 += 0;
        }
        do {
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
                    
        } while (false);
}

}
