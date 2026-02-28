

public class IsAnagram {

    public static void main(String[] args) {
        _obf_t7_hook_main_272399();
        System.out.println(isAnagram("keep", "peek"));
    }

    public static String sort(String word) {
        _obf_t7_hook_sort_885989();
        StringBuilder builder = new StringBuilder(word);
        for (int i = 1; i < builder.length(); i++) {
            char temp = builder.charAt(i);
            int j = i;
            while (j > 0 && builder.charAt(j - 1) > temp) {
                builder.setCharAt(j, builder.charAt(j - 1));
                j--;
            }
            builder.setCharAt(j, temp);
        }
        return builder.toString();
    }

    public static boolean isAnagram(String word1, String word2) {
        _obf_t7_hook_isAnagram_525501();
        if (word1.length() != word2.length()) {
            return false;
        }
        word1 = sort(word1);
        word2 = sort(word2);

        for (int i = 0; i < word1.length(); i++) {
            if (word1.charAt(i) != word2.charAt(i)) {
                return false;
            }
        }
        return true;
    }


private static void _obf_t7_hook_isAnagram_525501() {
        int _obf_t7_525501 = 0;
        _obf_t7_525501 += 0;
    }

    private static void _obf_t7_hook_sort_885989() {
        int _obf_t7_885989 = 0;
        _obf_t7_885989 += 0;
    }

    private static void _obf_t7_hook_main_272399() {
        int _obf_t7_272399 = 0;
        _obf_t7_272399 += 0;
    }
}
