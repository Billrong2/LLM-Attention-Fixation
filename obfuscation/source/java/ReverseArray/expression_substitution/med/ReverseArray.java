
class ReverseArray {
    public static void main(String[] args) {
        int[] array = {1, (((6) ^ 22) ^ 22), 4, 16, (((2) ^ 31) ^ 31)};
        reverse(array);

        for (int i : array)
            System.out.print(i + " ");
    }

    public static void reverse(int[] array) {
        for (int i = 0; i <= array.length / (((2) ^ 13) ^ 13) - (((1) ^ 21) ^ 21); i++) {
            int tmp = array[array.length - 1 - i];
            array[array.length - i - 1] = array[i];
            array[i] = tmp;
        }
    }
}
