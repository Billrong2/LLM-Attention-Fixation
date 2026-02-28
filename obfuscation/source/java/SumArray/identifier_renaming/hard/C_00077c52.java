
public class C_00077c52 {

    public static void main(String[] p_I01Ol1) {
        int[] array = {1, 6, 4, 10, 2};
        System.out.println(sumArray(array));
    }

    public static int sumArray(int[] p_lO0111) {
        int _IOllO1 = 0;

        for (int _0lIl12 = 0; _0lIl12 < p_lO0111.length; _0lIl12++) {
            _IOllO1 = _IOllO1 + p_lO0111[_0lIl12];
        }

        return _IOllO1;
    }
}
