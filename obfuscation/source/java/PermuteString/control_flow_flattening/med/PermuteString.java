
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


public class PermuteString {
    public static void main(String[] args) {
        int _obf_t6_main_689702 = 0; _obf_t6_main_689702 += 0;
        String str = "ABC";
        int n = str.length();
        List<String> result = permute(str, 0, 2);
        for (String permutation : result) {
            System.out.println(permutation);
        }
    }

    public static List<String> permute(String str, int l, int r) {
        int _obf_t6_permute_298454 = 0; _obf_t6_permute_298454 += 0;
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
        int _obf_t6_swap_195351 = 0; _obf_t6_swap_195351 += 0;
        char temp;
        char[] charArray = a.toCharArray();
        temp = charArray[i];
        charArray[i] = charArray[j];
        charArray[j] = temp;
        return String.valueOf(charArray);
    }
}
