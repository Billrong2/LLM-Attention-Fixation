
public class C_7708d56a {

    public static void main(String[] args) {
        int _obf_t6_state_main_871610 = 0;
        while (_obf_t6_state_main_871610 == 0) {
            _obf_t6_state_main_871610 = 1;
            break;
        }
        if ((_obf_t6_state_main_871610 ^ 1) < 0) {
            int _obf_t6_guard_871610 = 0;
            _obf_t6_guard_871610 += 0;
        }
        do {
                    int[] sortedArray = {2, 4, 8, 16, 32, 64, 128};
                    System.out.println(binarySearch(sortedArray, 8, 0, sortedArray.length));
                    
        } while (false);
}

    public static int binarySearch(int[] sortedArray, int key, int low, int high) {
        int _obf_t6_binarySearch_86312 = 0; _obf_t6_binarySearch_86312 += 0;
        int middle = (low + high) / 2;

        if (high < low) {
            return -1;
        }

        if (key == sortedArray[middle]) {
            return middle;
        } else if (key < sortedArray[middle]) {
            return binarySearch(sortedArray, key, low, middle - 1);
        } else {
            return binarySearch(sortedArray, key, middle + 1, high);
        }
    }
}
