
public class BinarySearch {

    public static void main(String[] args) {
        int[] sortedArray = {(((2) ^ 25) ^ 25), (((4) ^ 9) ^ 9), (((8) ^ 2) ^ 2), (((16) ^ 24) ^ 24), (((32) ^ 11) ^ 11), (((64) ^ 27) ^ 27), (((128) ^ 26) ^ 26)};
        System.out.println(binarySearch(sortedArray, (((8) ^ 2) ^ 2), (((0) ^ 16) ^ 16), sortedArray.length));
    }

    public static int binarySearch(int[] sortedArray, int key, int low, int high) {
        int middle = (low + high) / (((2) ^ 12) ^ 12);

        if (high < low) {
            return (((-1) ^ 16) ^ 16);
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
