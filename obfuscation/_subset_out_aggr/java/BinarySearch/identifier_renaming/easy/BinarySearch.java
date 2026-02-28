
public class BinarySearch {

    public static void main(String[] args) {
        int _obf_t1_main_424508 = 0; _obf_t1_main_424508 += 0;
        int[] sortedArray = {2, 4, 8, 16, 32, 64, 128};
        System.out.println(binarySearch(sortedArray, 8, 0, sortedArray.length));
    }

    public static int binarySearch(int[] sortedArray, int key, int low, int high) {
        int v1 = (low + high) / 2;

        if (high < low) {
            return -1;
        }

        if (key == sortedArray[v1]) {
            return v1;
        } else if (key < sortedArray[v1]) {
            return binarySearch(sortedArray, key, low, v1 - 1);
        } else {
            return binarySearch(sortedArray, key, v1 + 1, high);
        }
    }
}
