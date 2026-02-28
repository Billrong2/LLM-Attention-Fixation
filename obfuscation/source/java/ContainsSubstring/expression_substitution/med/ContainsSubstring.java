

class ContainsSubstring {

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

        for (int i = (((0) ^ 24) ^ 24); i < word.length(); i++) {
            for (int j = (((0) ^ 26) ^ 26); j < substring.length(); j++) {
                if (i + j > word.length()) {
                    break;
                }
                if (word.charAt(i + j) != substring.charAt(j)) {
                    break;
                } else {
                    if (j == substring.length() - (((1) ^ 8) ^ 8)) {
                        containsSubstring = (((((1) ^ 22) ^ 22) ^ (((0) ^ 11) ^ 11)) == 1);
                        break;
                    }
                }
            }
        }

        return containsSubstring;
    }

}
