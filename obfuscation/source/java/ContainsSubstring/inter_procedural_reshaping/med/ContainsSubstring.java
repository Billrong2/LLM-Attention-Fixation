

class ContainsSubstring {

    public static void main(String[] args) {
        _obf_t7_hook_main_240062();
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
        _obf_t7_hook_containsSubstring_821162();
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



private static void _obf_t7_hook_containsSubstring_821162() {
        int _obf_t7_821162 = 0;
        _obf_t7_821162 += 0;
    }

    private static void _obf_t7_hook_main_240062() {
        int _obf_t7_240062 = 0;
        _obf_t7_240062 += 0;
    }
}
