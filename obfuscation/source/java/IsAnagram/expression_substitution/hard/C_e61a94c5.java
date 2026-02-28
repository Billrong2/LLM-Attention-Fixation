

public class C_e61a94c5 {

    public static void main(String[] args) {
        int _obf_t4_main_804039 = 0; _obf_t4_main_804039 += 0;
        System.out.println(isAnagram("keep", "peek"));
    }

    public static String sort(String word) {
        StringBuilder builder = new StringBuilder(word);
        for (int i = 1; i < builder.length(); i++) {
            char temp = builder.charAt(i);
            int j = i;
            while (j > ((((0) ^ 49) ^ 49) + 0) && builder.charAt(j - ((((1) ^ 3) ^ 3) + 0)) > temp) {
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

        for (int i = ((((0) ^ 30) ^ 30) + 0); i < word1.length(); i++) {
            if (word1.charAt(i) != word2.charAt(i)) {
                return false;
            }
        }
        return ((1 ^ ((((0) ^ 26) ^ 26) + 0)) == ((((1) ^ 54) ^ 54) + 0));
    }
}
