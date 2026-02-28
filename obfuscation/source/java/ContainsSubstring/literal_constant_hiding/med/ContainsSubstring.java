

class ContainsSubstring {

    public static void main(String[] args) {
        System.out.println();
        System.out.println(_obf_t3_dec_970444("ZmFsc2U="));
        System.out.println();
        System.out.println(_obf_t3_dec_970444("RXJyb3I="));
        System.out.println();

        String word = _obf_t3_dec_970444("SGFtYnVyZw==");
        String substring = _obf_t3_dec_970444("YnVyZw==");
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



private static String _obf_t3_dec_970444(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
