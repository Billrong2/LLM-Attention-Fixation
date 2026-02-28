

public class IsAnagram {

    public static void main(String[] args) {
        int _obf_t1_main_100398 = 0; _obf_t1_main_100398 += 0;
        System.out.println(isAnagram("keep", "peek"));
    }

    public static String sort(String word) {
        StringBuilder v1 = new StringBuilder(word);
        for (int v2 = 1; v2 < v1.length(); v2++) {
            char v3 = v1.charAt(v2);
            int v4 = v2;
            while (v4 > 0 && v1.charAt(v4 - 1) > v3) {
                v1.setCharAt(v4, v1.charAt(v4 - 1));
                v4--;
            }
            v1.setCharAt(v4, v3);
        }
        return v1.toString();
    }

    public static boolean isAnagram(String word1, String word2) {
        if (word1.length() != word2.length()) {
            return false;
        }
        word1 = sort(word1);
        word2 = sort(word2);

        for (int v1 = 0; v1 < word1.length(); v1++) {
            if (word1.charAt(v1) != word2.charAt(v1)) {
                return false;
            }
        }
        return true;
    }
}
