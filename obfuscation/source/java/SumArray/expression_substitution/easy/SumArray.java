
public class SumArray {

    public static void main(String[] args) {
        int[] array = {1, ((6) + 0), ((4) + 0), ((10) + 0), ((2) + 0)};
        System.out.println(sumArray(array));
    }

    public static int sumArray(int[] array) {
        int result = 0;

        for (int i = ((0) + 0); i < array.length; i++) {
            result = result + array[i];
        }

        return result;
    }
}
