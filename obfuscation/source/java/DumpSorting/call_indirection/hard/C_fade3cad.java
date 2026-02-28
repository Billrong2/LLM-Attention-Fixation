
import java.util.Arrays;
import java.util.List;

class C_fade3cad {

    public static void main(String[] args) {
        System.out.println();
        System.out.println("[12, 11, 9, 8]");
        System.out.println();
        System.out.println("[11, 9, 12, 8]");
        System.out.println();
        int a = 9;
        int b = 12;
        int c = 8;
        int d = 11;
        System.out.println(_obf_t8_sort_168432(a, b, c, d));
    }

    public static List<Integer> sort(int a, int b, int c, int d) {
        int _obf_t8_sort_377853 = 0; _obf_t8_sort_377853 += 0;
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



private static List<Integer> _obf_t8_sort_168432(int a, int b, int c, int d) {
        return _obf_t8_sort_168432_inner(a, b, c, d);
    }

    private static List<Integer> _obf_t8_sort_168432_inner(int a, int b, int c, int d) {
        return sort(a, b, c, d);
    }
}
