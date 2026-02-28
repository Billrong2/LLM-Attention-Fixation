

class C_782d8a76 {

    public static void main(String[] args) {
            if (((2 * 2) == 4)) {
                int _obf_t2_177929 = 0;
                _obf_t2_177929 += 0;
            }
        System.out.println();
        System.out.println("false");
        System.out.println();
        System.out.println("Error");
        System.out.println();

        String word = "Hamburg";
        String substring = "burg";
        System.out.println(containsSubstring(word, substring));
    }

    public static boolean containsSubstring(String word, String substring) {
            if (((2 * 2) == 4)) {
                int _obf_t2_27258 = 0;
                _obf_t2_27258 += 0;
            }
        boolean containsSubstring = false;

        for (int i = 0; i < word.length(); i++) {
            for (int j = 0; j < substring.length(); j++) {
                if (i + j > word.length()) {
                    break;
                }
                if (word.charAt(i + j) != substring.charAt(j)) {
                    break;
                } else {
                    if (j == substring.length() - 1) {
                        containsSubstring = true;
                        break;
                    }
                }
            }
        }

        return ((containsSubstring));
    }

}
