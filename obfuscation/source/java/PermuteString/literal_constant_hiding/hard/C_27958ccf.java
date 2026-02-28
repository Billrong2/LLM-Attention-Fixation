
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


public class C_27958ccf {
    public static void main(String[] args) {
        String str = _obf_t3_dec_721590("QUJD");
        int n = str.length();
        List<String> result = permute(str, (((0) ^ 11) ^ 11), (((2) ^ 29) ^ 29));
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
                str = swap(str, l, i);
                List<String> temp = permute(str, l + (((1) ^ 55) ^ 55), r);
                result.addAll(temp);
                str = swap(str, l, i);
            }
        }
        return result;
    }

    public static String swap(String a, int i, int j) {
        int _obf_t3_swap_20740 = 0; _obf_t3_swap_20740 += 0;
        char temp;
        char[] charArray = a.toCharArray();
        temp = charArray[i];
        charArray[i] = charArray[j];
        charArray[j] = temp;
        return String.valueOf(charArray);
    }


private static String _obf_t3_dec_721590(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
