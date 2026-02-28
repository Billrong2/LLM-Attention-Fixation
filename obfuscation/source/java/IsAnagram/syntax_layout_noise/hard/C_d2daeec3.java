

public class C_d2daeec3 {

    public static void main(String[] args) {
            if (((2 * 2) == 4)) {
                int _obf_t2_362936 = 0;
                _obf_t2_362936 += 0;
            }
        System.out.println(isAnagram("keep", "peek"));
    }

    public static String sort(String word) {
            if (((2 * 2) == 4)) {
                int _obf_t2_171830 = 0;
                _obf_t2_171830 += 0;
            }
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
        return ((builder.toString()));
    }

    public static boolean isAnagram(String word1, String word2) {
            if (((2 * 2) == 4)) {
                int _obf_t2_727684 = 0;
                _obf_t2_727684 += 0;
            }
        if (word1.length() != word2.length()) {
            return ((false));
        }
        word1 = sort(word1);
        word2 = sort(word2);

        for (int i = 0; i < word1.length(); i++) {
            if (word1.charAt(i) != word2.charAt(i)) {
                return ((false));
            }
        }
        return ((true));
    }
}
