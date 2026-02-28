
public class C_433eefe2 {

    public static void main(String[] args) {
        int[] sortedArray = {(((((2) ^ 49) ^ 49) ^ 59) ^ 59), (((((4) ^ 19) ^ 19) ^ 47) ^ 47), (((((8) ^ 42) ^ 42) ^ 47) ^ 47), (((((16) ^ 20) ^ 20) ^ 23) ^ 23), (((((32) ^ 43) ^ 43) ^ 51) ^ 51), (((((64) ^ 27) ^ 27) ^ 2) ^ 2), (((((128) ^ 31) ^ 31) ^ 27) ^ 27)};
        System.out.println(binarySearch(sortedArray, (((((8) ^ 32) ^ 32) ^ 30) ^ 30), (((((0) ^ 45) ^ 45) ^ 60) ^ 60), sortedArray.length));
    }

    public static int binarySearch(int[] sortedArray, int key, int low, int high) {
        int middle = (low + high) / (((((2) ^ 22) ^ 22) ^ 48) ^ 48);

        if (high < low) {
            return (((((-1) ^ 24) ^ 24) ^ 42) ^ 42);
        }

        if (key == sortedArray[middle]) {
            return middle;
        } else if (key < sortedArray[middle]) {
            return binarySearch(sortedArray, key, low, middle - (((((1) ^ 19) ^ 19) ^ 20) ^ 20));
        } else {
            return binarySearch(sortedArray, key, middle + (((((1) ^ 27) ^ 27) ^ 21) ^ 21), high);
        }
    }
}
