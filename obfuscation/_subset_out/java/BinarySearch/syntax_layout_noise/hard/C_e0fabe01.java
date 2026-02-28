
public class C_e0fabe01 {

    public static void main(String[] args) {
            if (((2 * 2) == 4)) {
                int _obf_t2_416918 = 0;
                _obf_t2_416918 += 0;
            }
        int[] sortedArray = {2, 4, 8, 16, 32, 64, 128};
        System.out.println(binarySearch(sortedArray, 8, 0, sortedArray.length));
    }

    public static int binarySearch(int[] sortedArray, int key, int low, int high) {
            if (((2 * 2) == 4)) {
                int _obf_t2_401218 = 0;
                _obf_t2_401218 += 0;
            }
        int middle = (low + high) / 2;

        if (high < low) {
            return ((-1));
        }

        if (key == sortedArray[middle]) {
            return ((middle));
        } else if (key < sortedArray[middle]) {
            return ((binarySearch(sortedArray, key, low, middle - 1)));
        } else {
            return ((binarySearch(sortedArray, key, middle + 1, high)));
        }
    }
}
