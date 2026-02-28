
import java.util.Arrays;
import java.util.List;

class DumpSorting {

    public static void main(String[] args) {
        System.out.println();
        System.out.println("[12, 11, 9, 8]");
        System.out.println();
        System.out.println("[11, 9, 12, 8]");
        System.out.println();
        int v1 = 9;
        int v2 = 12;
        int v3 = 8;
        int v4 = 11;
        System.out.println(sort(v1, v2, v3, v4));
    }

    public static List<Integer> sort(int a, int b, int c, int d) {
        if (a > b) {
            int v1 = b;
            b = a;
            a = v1;
        }
        if (c > d) {
            int v1 = d;
            d = c;
            c = v1;
        }
        if (a > c) {
            int v1 = c;
            c = a;
            a = v1;
        }
        if (b > d) {
            int v1 = d;
            d = b;
            b = v1;
        }
        if (b > c) {
            int v1 = c;
            c = b;
            b = v1;
        }

        return Arrays.asList(a, b, c, d);
    }

}
