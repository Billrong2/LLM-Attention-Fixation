
public class C_ff07e88a {

    public static void main(String[] p_1lIIO1) {
        int[] sortedArray = {2, 4, 8, 16, 32, 64, 128};
        System.out.println(binarySearch(sortedArray, 8, 0, sortedArray.length));
    }

    public static int binarySearch(int[] p_O1I011, int p_10l0l2, int p_0OI013, int p_0l01I4) {
        int _O01lO1 = (p_0OI013 + p_0l01I4) / 2;

        if (p_0l01I4 < p_0OI013) {
            return -1;
        }

        if (p_10l0l2 == p_O1I011[_O01lO1]) {
            return _O01lO1;
        } else if (p_10l0l2 < p_O1I011[_O01lO1]) {
            return binarySearch(p_O1I011, p_10l0l2, p_0OI013, _O01lO1 - 1);
        } else {
            return binarySearch(p_O1I011, p_10l0l2, _O01lO1 + 1, p_0l01I4);
        }
    }
}
