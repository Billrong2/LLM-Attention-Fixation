

public class IsAnagram {

    public static void main(String[] args) {
        do {
            {
                int _obf_t6_easy_34970 = 0;
                _obf_t6_easy_34970 += 0;
                    System.out.println(isAnagram("keep", "peek"));
                    
            }
        } while (false);
}

    public static String sort(String word) {
        do {
            {
                int _obf_t6_easy_845255 = 0;
                _obf_t6_easy_845255 += 0;
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
        } while (false);
}

    public static boolean isAnagram(String word1, String word2) {
        int _obf_t6_isAnagram_72887 = 0; _obf_t6_isAnagram_72887 += 0;
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
}
