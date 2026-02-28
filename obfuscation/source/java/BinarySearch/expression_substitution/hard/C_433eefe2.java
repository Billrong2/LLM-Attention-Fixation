
public class C_433eefe2 {

    public static void main(String[] args) {
        int[] sortedArray = {2, 4, 8, ((((16) ^ 3) ^ 3) + 0), ((((32) ^ 47) ^ 47) + 0), ((((64) ^ 20) ^ 20) + 0), ((((128) ^ 53) ^ 53) + 0)};
        System.out.println(binarySearch(sortedArray, 8, 0, sortedArray.length));
    }

    public static int binarySearch(int[] sortedArray, int key, int low, int high) {
        int middle = (low + high) / 2;

        if (high < low) {
            return ((((-1) ^ 28) ^ 28) + 0);
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
