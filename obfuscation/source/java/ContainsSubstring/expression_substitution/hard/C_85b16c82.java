

class C_85b16c82 {

    public static void main(String[] args) {
        int _obf_t4_main_398942 = 0; _obf_t4_main_398942 += 0;
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
        boolean containsSubstring = false;

        for (int i = 0; i < word.length(); i++) {
            for (int j = 0; j < substring.length(); j++) {
                if (i + j > word.length()) {
                    break;
                }
                if (word.charAt(i + j) != substring.charAt(j)) {
                    break;
                } else {
                    if (j == substring.length() - ((((1) ^ 31) ^ 31) + 0)) {
                        containsSubstring = ((((((1) ^ 10) ^ 10) + 0) ^ ((((0) ^ 38) ^ 38) + 0)) == 1);
                        break;
                    }
                }
            }
        }

        return containsSubstring;
    }

}
