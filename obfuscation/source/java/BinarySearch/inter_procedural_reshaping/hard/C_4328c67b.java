
public class C_4328c67b {

    public static void main(String[] args) {
        _obf_t7_hook_main_116299();
        int[] sortedArray = {2, 4, 8, 16, 32, 64, 128};
        System.out.println(binarySearch(sortedArray, 8, 0, sortedArray.length));
    }

    public static int binarySearch(int[] sortedArray, int key, int low, int high) {
        _obf_t7_hook_binarySearch_33626();
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


private static void _obf_t7_hook_binarySearch_33626() {
        int _obf_t7_33626 = 0;
        _obf_t7_33626 += 0;
    }

    private static void _obf_t7_hook_main_116299() {
        int _obf_t7_116299 = 0;
        _obf_t7_116299 += 0;
    }
}
