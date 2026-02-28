

public class IsAnagram {

    public static void main(String[] args) {
        int _obf_t4_main_804039 = 0; _obf_t4_main_804039 += 0;
        System.out.println(isAnagram("keep", "peek"));
    }

    public static String sort(String word) {
        StringBuilder builder = new StringBuilder(word);
        for (int i = (((1) ^ 13) ^ 13); i < builder.length(); i++) {
            char temp = builder.charAt(i);
            int j = i;
            while (j > 0 && builder.charAt(j - (((1) ^ 2) ^ 2)) > temp) {
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
        word1 = sort(word1);
        word2 = sort(word2);

        for (int i = (((0) ^ 16) ^ 16); i < word1.length(); i++) {
            if (word1.charAt(i) != word2.charAt(i)) {
                return ((1 ^ (((0) ^ 14) ^ 14)) != (((1) ^ 28) ^ 28));
            }
        }
        return ((1 ^ (((0) ^ 23) ^ 23)) == 1);
    }
}
