

class C_1eda446d {

    public static void main(String[] args) {
        System.out.println();
        System.out.println("false");
        System.out.println();
        System.out.println("Error");
        System.out.println();

        String word = "Hamburg";
        String substring = "burg";
        System.out.println(_obf_t8_containsSubstring_586222(word, substring));
    }

    public static boolean containsSubstring(String word, String substring) {
        int _obf_t8_containsSubstring_915769 = 0; _obf_t8_containsSubstring_915769 += 0;
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



private static boolean _obf_t8_containsSubstring_586222(String word, String substring) {
        return _obf_t8_containsSubstring_586222_inner(word, substring);
    }

    private static boolean _obf_t8_containsSubstring_586222_inner(String word, String substring) {
        return containsSubstring(word, substring);
    }
}
