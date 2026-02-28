
public class C_c7dc7cd7 {

    public static void main(String[] args) {
        int[] sortedArray = {(((2) ^ 19) ^ 19), (((4) ^ 63) ^ 63), (((8) ^ 23) ^ 23), (((16) ^ 44) ^ 44), (((32) ^ 62) ^ 62), (((64) ^ 62) ^ 62), (((128) ^ 37) ^ 37)};
        System.out.println(binarySearch(sortedArray, (((8) ^ 25) ^ 25), (((0) ^ 22) ^ 22), sortedArray.length));
    }

    public static int binarySearch(int[] sortedArray, int key, int low, int high) {
        int middle = (low + high) / (((2) ^ 7) ^ 7);

        if (high < low) {
            return (((-1) ^ 44) ^ 44);
        }

        if (key == sortedArray[middle]) {
            return middle;
        } else if (key < sortedArray[middle]) {
            return binarySearch(sortedArray, key, low, middle - (((1) ^ 20) ^ 20));
        } else {
            return binarySearch(sortedArray, key, middle + (((1) ^ 27) ^ 27), high);
        }
    }
}
