
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


public class C_4b17ee63 {
    public static void main(String[] args) {
        _obf_t7_hook_main_726515();
        String str = "ABC";
        int n = str.length();
        List<String> result = permute(str, 0, 2);
        for (String permutation : result) {
            System.out.println(permutation);
        }
    }

    public static List<String> permute(String str, int l, int r) {
        _obf_t7_hook_permute_222860();
        List<String> result = new ArrayList<>();
        if (l == r)
            result.add(str);
        else {
            for (int i = l; i <= r; i++) {
                str = swap(str, l, i);
                List<String> temp = permute(str, l + 1, r);
                result.addAll(temp);
                str = swap(str, l, i);
            }
        }
        return result;
    }

    public static String swap(String a, int i, int j) {
        _obf_t7_hook_swap_479892();
        char temp;
        char[] charArray = a.toCharArray();
        temp = charArray[i];
        charArray[i] = charArray[j];
        charArray[j] = temp;
        return String.valueOf(charArray);
    }


private static void _obf_t7_hook_swap_479892() {
        int _obf_t7_479892 = 0;
        _obf_t7_479892 += 0;
    }

    private static void _obf_t7_hook_permute_222860() {
        int _obf_t7_222860 = 0;
        _obf_t7_222860 += 0;
    }

    private static void _obf_t7_hook_main_726515() {
        int _obf_t7_726515 = 0;
        _obf_t7_726515 += 0;
    }
}
