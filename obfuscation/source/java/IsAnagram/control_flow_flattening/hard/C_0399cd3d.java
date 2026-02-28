

public class C_0399cd3d {

    public static void main(String[] args) {
        int _obf_t6_main_415160 = 0; _obf_t6_main_415160 += 0;
        System.out.println(isAnagram("keep", "peek"));
    }

    public static String sort(String word) {
        int _obf_t6_sort_122795 = 0; _obf_t6_sort_122795 += 0;
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
