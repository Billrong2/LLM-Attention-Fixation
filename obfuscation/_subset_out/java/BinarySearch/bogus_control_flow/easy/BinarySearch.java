
public class BinarySearch {

    public static void main(String[] args) {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_main_506244 = 0;
            _obf_t5_main_506244++;
        }
        int[] sortedArray = {2, 4, 8, 16, 32, 64, 128};
        System.out.println(binarySearch(sortedArray, 8, 0, sortedArray.length));
    }

    public static int binarySearch(int[] sortedArray, int key, int low, int high) {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_binarySearch_407292 = 0;
            _obf_t5_binarySearch_407292++;
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
