
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


public class PermuteString {
    public static void main(String[] args) {
        String str = "ABC";
        int n = str.length();
        List<String> result = _obf_t8_permute_973062(str, 0, 2);
        for (String permutation : result) {
            System.out.println(permutation);
        }
    }

    public static List<String> permute(String str, int l, int r) {
        List<String> result = new ArrayList<>();
        if (l == r)
            result.add(str);
        else {
            for (int i = l; i <= r; i++) {
                str = _obf_t8_swap_196088(str, l, i);
                List<String> temp = _obf_t8_permute_973062(str, l + 1, r);
                result.addAll(temp);
                str = _obf_t8_swap_196088(str, l, i);
            }
        }
        return result;
    }

    public static String swap(String a, int i, int j) {
        int _obf_t8_swap_935658 = 0; _obf_t8_swap_935658 += 0;
        char temp;
        char[] charArray = a.toCharArray();
        temp = charArray[i];
        charArray[i] = charArray[j];
        charArray[j] = temp;
        return String.valueOf(charArray);
    }


private static List<String> _obf_t8_permute_973062(String str, int l, int r) {
        int _obf_sel = 2;
        switch (_obf_sel) {
            case 2: return permute(str, l, r);
            default: return permute(str, l, r);
        }
    }

    private static String _obf_t8_swap_196088(String a, int i, int j) {
        int _obf_sel = 2;
        switch (_obf_sel) {
            case 2: return swap(a, i, j);
            default: return swap(a, i, j);
        }
    }
}
