
public class C_f4b8faf6 {

    public static void main(String[] args) {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_main_955964 = 0;
            _obf_t5_main_955964++;
        }
        if (((2 * 2) + 1) > 0) {
            int _obf_t5_main_955964_m = 0;
            _obf_t5_main_955964_m += 0;
        } else {
            int _obf_t5_main_955964_e = 1;
            _obf_t5_main_955964_e -= 1;
        }
        int _obf_t5_main_955964_h = (1 ^ 1);
        if (_obf_t5_main_955964_h != 0) {
            _obf_t5_main_955964_h += 1;
        }
        int[] sortedArray = {2, 4, 8, 16, 32, 64, 128};
        System.out.println(binarySearch(sortedArray, 8, 0, sortedArray.length));
    }

    public static int binarySearch(int[] sortedArray, int key, int low, int high) {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_binarySearch_876875 = 0;
            _obf_t5_binarySearch_876875++;
        }
        if (((2 * 2) + 1) > 0) {
            int _obf_t5_binarySearch_876875_m = 0;
            _obf_t5_binarySearch_876875_m += 0;
        } else {
            int _obf_t5_binarySearch_876875_e = 1;
            _obf_t5_binarySearch_876875_e -= 1;
        }
        int _obf_t5_binarySearch_876875_h = (1 ^ 1);
        if (_obf_t5_binarySearch_876875_h != 0) {
            _obf_t5_binarySearch_876875_h += 1;
        }
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
