
public class C_686f7350 {

    public static void main(String[] p_l10I01) {
        int[] field = {1, 2, 3, 4, 4};
        System.out.println(rabbitTortoise(field));
    }

    public static int rabbitTortoise(int[] p_100111) {
        int _O0O0l1 = p_100111[0];
        int _III1O2 = p_100111[p_100111[0]];

        while (_O0O0l1 != _III1O2) {
            _O0O0l1 = p_100111[_O0O0l1];
            _III1O2 = p_100111[p_100111[_III1O2]];
        }

        _III1O2 = 0;
        while (_O0O0l1 != _III1O2) {
            _O0O0l1 = p_100111[_O0O0l1];
            _III1O2 = p_100111[_III1O2];
        }
        return _III1O2;
    }
}
