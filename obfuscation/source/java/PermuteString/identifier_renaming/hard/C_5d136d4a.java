
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


public class C_5d136d4a {
    public static void main(String[] p_lI0II1) {
        String _IIlI01 = "ABC";
        int _OOO0O2 = _IIlI01.length();
        List<String> _10ll03 = permute(_IIlI01, 0, 2);
        for (String permutation : _10ll03) {
            System.out.println(permutation);
        }
    }

    public static List<String> permute(String p_1l0001, int p_01lO02, int p_00O0l3) {
        List<String> _10lOO1 = new ArrayList<>();
        if (p_01lO02 == p_00O0l3)
            _10lOO1.add(p_1l0001);
        else {
            for (int _00I1I2 = p_01lO02; _00I1I2 <= p_00O0l3; _00I1I2++) {
                p_1l0001 = swap(p_1l0001, p_01lO02, _00I1I2);
                List<String> _0lOl03 = permute(p_1l0001, p_01lO02 + 1, p_00O0l3);
                _10lOO1.addAll(_0lOl03);
                p_1l0001 = swap(p_1l0001, p_01lO02, _00I1I2);
            }
        }
        return _10lOO1;
    }

    public static String swap(String p_O0llO1, int p_01III2, int p_O0O0I3) {
        char _l1IIl1;
        char[] charArray = p_O0llO1.toCharArray();
        _l1IIl1 = charArray[p_01III2];
        charArray[p_01III2] = charArray[p_O0O0I3];
        charArray[p_O0O0I3] = _l1IIl1;
        return String.valueOf(charArray);
    }
}
