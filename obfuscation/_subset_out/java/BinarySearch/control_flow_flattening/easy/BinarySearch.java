
public class BinarySearch {

    public static void main(String[] args) {
        do {
            {
                int _obf_t6_easy_47088 = 0;
                _obf_t6_easy_47088 += 0;
                    int[] sortedArray = {2, 4, 8, 16, 32, 64, 128};
                    System.out.println(binarySearch(sortedArray, 8, 0, sortedArray.length));
                    
            }
        } while (false);
}

    public static int binarySearch(int[] sortedArray, int key, int low, int high) {
        do {
            {
                int _obf_t6_easy_120191 = 0;
                _obf_t6_easy_120191 += 0;
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
        } while (false);
}
}
