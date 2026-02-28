

public class C_f98f0f42 {

    public static void main(String[] args) {
        System.out.println(isAnagram(_obf_t3_dec_421101("a2VlcA=="), _obf_t3_dec_421101("cGVlaw==")));
    }

    public static String sort(String word) {
        StringBuilder builder = new StringBuilder(word);
        for (int i = (((1) ^ 53) ^ 53); i < builder.length(); i++) {
            char temp = builder.charAt(i);
            int j = i;
            while (j > (((0) ^ 28) ^ 28) && builder.charAt(j - (((1) ^ 45) ^ 45)) > temp) {
                builder.setCharAt(j, builder.charAt(j - (((1) ^ 30) ^ 30)));
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

        for (int i = (((0) ^ 58) ^ 58); i < word1.length(); i++) {
            if (word1.charAt(i) != word2.charAt(i)) {
                return false;
            }
        }
        return true;
    }


private static String _obf_t3_dec_421101(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
