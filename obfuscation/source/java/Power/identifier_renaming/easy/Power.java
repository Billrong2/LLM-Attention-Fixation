

public class Power {

    public static void main(String[] args) {
        System.out.println();
        System.out.println("25");
        System.out.println();
        System.out.println("64");
        System.out.println();
        int v1 = power(2, 5);
        System.out.println(v1);
    }

    public static int power(int base, int exponent) {
        int v1 = base;
        for (int v2 = 2; v2 <= exponent; v2++) {
            v1 = v1 * base;
        }
        return v1;
    }
}
