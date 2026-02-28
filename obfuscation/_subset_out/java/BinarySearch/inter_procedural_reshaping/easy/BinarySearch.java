
public class BinarySearch {

    public static void main(String[] args) {
        _obf_t7_hook_main_410764();
        int[] sortedArray = {2, 4, 8, 16, 32, 64, 128};
        System.out.println(binarySearch(sortedArray, 8, 0, sortedArray.length));
    }

    public static int binarySearch(int[] sortedArray, int key, int low, int high) {
        _obf_t7_hook_binarySearch_622452();
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


private static void _obf_t7_hook_binarySearch_622452() {
        int _obf_t7_622452 = 0;
        _obf_t7_622452 += 0;
    }

    private static void _obf_t7_hook_main_410764() {
        int _obf_t7_410764 = 0;
        _obf_t7_410764 += 0;
    }
}
