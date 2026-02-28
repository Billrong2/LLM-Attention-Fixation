
import java.util.Arrays;
import java.util.List;

class C_8c103bde {

    public static void main(String[] args) {
        System.out.println();
        System.out.println(_obf_t3_dec_66461("WzEyLCAxMSwgOSwgOF0="));
        System.out.println();
        System.out.println(_obf_t3_dec_66461("WzExLCA5LCAxMiwgOF0="));
        System.out.println();
        int a = (((9) ^ 42) ^ 42);
        int b = (((12) ^ 51) ^ 51);
        int c = (((8) ^ 33) ^ 33);
        int d = (((11) ^ 18) ^ 18);
        System.out.println(sort(a, b, c, d));
    }

    public static List<Integer> sort(int a, int b, int c, int d) {
        int _obf_t3_sort_236079 = 0; _obf_t3_sort_236079 += 0;
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



private static String _obf_t3_dec_66461(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
