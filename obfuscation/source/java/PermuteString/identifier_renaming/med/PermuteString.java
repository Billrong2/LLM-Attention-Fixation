
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


public class PermuteString {
    public static void main(String[] _p1) {
        String _o1 = "ABC";
        int _o2 = _o1.length();
        List<String> _o3 = permute(_o1, 0, 2);
        for (String permutation : _o3) {
            System.out.println(permutation);
        }
    }

    public static List<String> permute(String _p1, int _p2, int _p3) {
        List<String> _o1 = new ArrayList<>();
        if (_p2 == _p3)
            _o1.add(_p1);
        else {
            for (int _o2 = _p2; _o2 <= _p3; _o2++) {
                _p1 = swap(_p1, _p2, _o2);
                List<String> _o3 = permute(_p1, _p2 + 1, _p3);
                _o1.addAll(_o3);
                _p1 = swap(_p1, _p2, _o2);
            }
        }
        return _o1;
    }

    public static String swap(String _p1, int _p2, int _p3) {
        char _o1;
        char[] charArray = _p1.toCharArray();
        _o1 = charArray[_p2];
        charArray[_p2] = charArray[_p3];
        charArray[_p3] = _o1;
        return String.valueOf(charArray);
    }
}
