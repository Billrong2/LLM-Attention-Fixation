

public class IsAnagram {

    public static void main(String[] args) {
        System.out.println(_obf_t8_isAnagram_941909("keep", "peek"));
    }

    public static String sort(String word) {
        int _obf_t8_sort_763294 = 0; _obf_t8_sort_763294 += 0;
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
        if (word1.length() != word2.length()) {
            return false;
        }
        word1 = _obf_t8_sort_603389(word1);
        word2 = _obf_t8_sort_603389(word2);

        for (int i = 0; i < word1.length(); i++) {
            if (word1.charAt(i) != word2.charAt(i)) {
                return false;
            }
        }
        return true;
    }


private static String _obf_t8_sort_603389(String word) {
        return sort(word);
    }

    private static boolean _obf_t8_isAnagram_941909(String word1, String word2) {
        return isAnagram(word1, word2);
    }
}
