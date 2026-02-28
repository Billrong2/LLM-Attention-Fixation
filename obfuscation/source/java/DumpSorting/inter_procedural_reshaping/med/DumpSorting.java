
import java.util.Arrays;
import java.util.List;

class DumpSorting {

    public static void main(String[] args) {
        _obf_t7_hook_main_739397();
        System.out.println();
        System.out.println("[12, 11, 9, 8]");
        System.out.println();
        System.out.println("[11, 9, 12, 8]");
        System.out.println();
        int a = 9;
        int b = 12;
        int c = 8;
        int d = 11;
        System.out.println(sort(a, b, c, d));
    }

    public static List<Integer> sort(int a, int b, int c, int d) {
        _obf_t7_hook_sort_684959();
        if (a > b) {
            int temp = b;
            b = a;
            a = temp;
        }
        if (c > d) {
            int temp = d;
            d = c;
            c = temp;
        }
        if (a > c) {
            int temp = c;
            c = a;
            a = temp;
        }
        if (b > d) {
            int temp = d;
            d = b;
            b = temp;
        }
        if (b > c) {
            int temp = c;
            c = b;
            b = temp;
        }

        return Arrays.asList(a, b, c, d);
    }



private static void _obf_t7_hook_sort_684959() {
        int _obf_t7_684959 = 0;
        _obf_t7_684959 += 0;
    }

    private static void _obf_t7_hook_main_739397() {
        int _obf_t7_739397 = 0;
        _obf_t7_739397 += 0;
    }
}
