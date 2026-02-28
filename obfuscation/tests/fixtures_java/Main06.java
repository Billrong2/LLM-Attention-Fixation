public class Main06 {
    static int f(int n) {
        int s = 0;
        for (int i = 0; i < n; i++) {
            s += i;
        }
        return s;
    }

    public static void main(String[] args) {
        System.out.println(f(7));
    }
}
