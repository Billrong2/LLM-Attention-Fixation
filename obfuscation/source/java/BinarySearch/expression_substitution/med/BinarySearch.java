
public class BinarySearch {

    public static void main(String[] args) {
        int[] sortedArray = {(((2) ^ 25) ^ 25), 4, (((8) ^ 24) ^ 24), (((16) ^ 22) ^ 22), 32, (((64) ^ 12) ^ 12), (((128) ^ 22) ^ 22)};
        System.out.println(binarySearch(sortedArray, 8, (((0) ^ 2) ^ 2), sortedArray.length));
    }

    public static int binarySearch(int[] sortedArray, int key, int low, int high) {
        int middle = (low + high) / 2;

        if (high < low) {
            return (((-1) ^ 15) ^ 15);
        }

        if (key == sortedArray[middle]) {
            return middle;
        } else if (key < sortedArray[middle]) {
            return binarySearch(sortedArray, key, low, middle - (((1) ^ 22) ^ 22));
        } else {
            return binarySearch(sortedArray, key, middle + (((1) ^ 10) ^ 10), high);
        }
    }
}
