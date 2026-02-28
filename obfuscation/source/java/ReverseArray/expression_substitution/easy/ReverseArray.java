
class ReverseArray {
    public static void main(String[] args) {
        int[] array = {((1) + 0), ((6) + 0), ((4) + 0), ((16) + 0), ((2) + 0)};
        reverse(array);

        for (int i : array)
            System.out.print(i + " ");
    }

    public static void reverse(int[] array) {
        for (int i = ((0) + 0); i <= array.length / ((2) + 0) - ((1) + 0); i++) {
            int tmp = array[array.length - ((1) + 0) - i];
            array[array.length - i - 1] = array[i];
            array[i] = tmp;
        }
    }
}
