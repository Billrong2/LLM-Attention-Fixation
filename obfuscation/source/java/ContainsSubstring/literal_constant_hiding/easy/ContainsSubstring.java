

class ContainsSubstring {

    public static void main(String[] args) {
        System.out.println();
        System.out.println(("" + "false"));
        System.out.println();
        System.out.println(("" + "Error"));
        System.out.println();

        String word = ("" + "Hamburg");
        String substring = ("" + "burg");
        System.out.println(containsSubstring(word, substring));
    }

    public static boolean containsSubstring(String word, String substring) {
        int _obf_t3_containsSubstring_98109 = 0; _obf_t3_containsSubstring_98109 += 0;
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

        return containsSubstring;
    }

}
