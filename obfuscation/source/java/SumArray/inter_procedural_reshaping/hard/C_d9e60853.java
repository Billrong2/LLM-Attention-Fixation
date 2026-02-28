
public class C_d9e60853 {

    public static void main(String[] args) {
        _obf_t7_hook_main_171719();
        int[] array = {1, 6, 4, 10, 2};
        System.out.println(sumArray(array));
    }

    public static int sumArray(int[] array) {
        _obf_t7_hook_sumArray_76712();
        int result = 0;

        for (int i = 0; i < array.length; i++) {
            result = result + array[i];
        }

        return result;
    }


private static void _obf_t7_hook_sumArray_76712() {
        int _obf_t7_76712 = 0;
        _obf_t7_76712 += 0;
    }

    private static void _obf_t7_hook_main_171719() {
        int _obf_t7_171719 = 0;
        _obf_t7_171719 += 0;
    }
}
