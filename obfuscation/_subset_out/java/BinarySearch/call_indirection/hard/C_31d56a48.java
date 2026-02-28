
public class C_31d56a48 {

    public static void main(String[] args) {
        int[] sortedArray = {2, 4, 8, 16, 32, 64, 128};
        System.out.println(_obf_t8_binarySearch_127308(sortedArray, 8, 0, sortedArray.length));
    }

    public static int binarySearch(int[] sortedArray, int key, int low, int high) {
        int middle = (low + high) / 2;

        if (high < low) {
            return -1;
        }

        if (key == sortedArray[middle]) {
            return middle;
        } else if (key < sortedArray[middle]) {
            return _obf_t8_binarySearch_127308(sortedArray, key, low, middle - 1);
        } else {
            return _obf_t8_binarySearch_127308(sortedArray, key, middle + 1, high);
        }
    }


private static int _obf_t8_binarySearch_127308(int[] sortedArray, int key, int low, int high) {
        return _obf_t8_binarySearch_127308_inner(sortedArray, key, low, high);
    }

    private static int _obf_t8_binarySearch_127308_inner(int[] sortedArray, int key, int low, int high) {
        return binarySearch(sortedArray, key, low, high);
    }
}
