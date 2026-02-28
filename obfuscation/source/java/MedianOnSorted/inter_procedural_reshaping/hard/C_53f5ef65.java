
public class C_53f5ef65 {
    public static void main(String[] args) {
        _obf_t7_hook_main_591495();
        int[] array = {1, 2, 4, 5, 6, 16};

        System.out.println(median(array));
    }

    public static float median(int[] array) {
        _obf_t7_hook_median_598742();
        float b;
        if (array.length % 2 == 1)
            b = array[array.length / 2];
        else
            b = (array[array.length / 2 - 1] + array[array.length / 2]) / 2f;
        return b;
    }


private static void _obf_t7_hook_median_598742() {
        int _obf_t7_598742 = 0;
        _obf_t7_598742 += 0;
    }

    private static void _obf_t7_hook_main_591495() {
        int _obf_t7_591495 = 0;
        _obf_t7_591495 += 0;
    }
}
