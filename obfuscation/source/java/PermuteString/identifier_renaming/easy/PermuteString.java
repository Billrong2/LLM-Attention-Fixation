
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


public class PermuteString {
    public static void main(String[] args) {
        String v1 = "ABC";
        int v2 = v1.length();
        List<String> v3 = permute(v1, 0, 2);
        for (String permutation : v3) {
            System.out.println(permutation);
        }
    }

    public static List<String> permute(String str, int l, int r) {
        List<String> v1 = new ArrayList<>();
        if (l == r)
            v1.add(str);
        else {
            for (int v2 = l; v2 <= r; v2++) {
                str = swap(str, l, v2);
                List<String> v3 = permute(str, l + 1, r);
                v1.addAll(v3);
                str = swap(str, l, v2);
            }
        }
        return v1;
    }

    public static String swap(String a, int i, int j) {
        char v1;
        char[] charArray = a.toCharArray();
        v1 = charArray[i];
        charArray[i] = charArray[j];
        charArray[j] = v1;
        return String.valueOf(charArray);
    }
}
