
public class C_ff07e88a {

    public static void main(String[] p_Il1Ol1) {
        int[] sortedArray = {2, 4, 8, 16, 32, 64, 128};
        System.out.println(binarySearch(sortedArray, 8, 0, sortedArray.length));
    }

    public static int binarySearch(int[] p_1l1lO1, int p_1O1I02, int p_1l1l13, int p_0lIOO4) {
        int _0O0111 = (p_1l1l13 + p_0lIOO4) / 2;

        if (p_0lIOO4 < p_1l1l13) {
            return -1;
        }

        if (p_1O1I02 == p_1l1lO1[_0O0111]) {
            return _0O0111;
        } else if (p_1O1I02 < p_1l1lO1[_0O0111]) {
            return binarySearch(p_1l1lO1, p_1O1I02, p_1l1l13, _0O0111 - 1);
        } else {
            return binarySearch(p_1l1lO1, p_1O1I02, _0O0111 + 1, p_0lIOO4);
        }
    }
}
