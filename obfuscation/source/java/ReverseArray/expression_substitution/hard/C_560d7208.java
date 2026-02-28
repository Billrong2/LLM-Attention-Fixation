
class C_560d7208 {
    public static void main(String[] args) {
        int[] array = {1, ((((6) ^ 43) ^ 43) + 0), 4, 16, ((((2) ^ 61) ^ 61) + 0)};
        reverse(array);

        for (int i : array)
            System.out.print(i + " ");
    }

    public static void reverse(int[] array) {
        for (int i = 0; i <= array.length / 2 - ((((1) ^ 45) ^ 45) + 0); i++) {
            int tmp = array[array.length - 1 - i];
            array[array.length - i - 1] = array[i];
            array[i] = tmp;
        }
    }
}
