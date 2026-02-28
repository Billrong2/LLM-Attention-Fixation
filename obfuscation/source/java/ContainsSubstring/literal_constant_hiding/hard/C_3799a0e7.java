

class C_3799a0e7 {

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
        boolean containsSubstring = false;

        for (int i = (((0) ^ 43) ^ 43); i < word.length(); i++) {
            for (int j = (((0) ^ 59) ^ 59); j < substring.length(); j++) {
                if (i + j > word.length()) {
                    break;
                }
                if (word.charAt(i + j) != substring.charAt(j)) {
                    break;
                } else {
                    if (j == substring.length() - (((1) ^ 14) ^ 14)) {
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
