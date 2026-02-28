

class C_973f5f69 {

    public static void main(String[] args) {
        int _obf_t6_state_main_215394 = 0;
        while (_obf_t6_state_main_215394 == 0) {
            _obf_t6_state_main_215394 = 1;
            break;
        }
        if ((_obf_t6_state_main_215394 ^ 1) < 0) {
            int _obf_t6_guard_215394 = 0;
            _obf_t6_guard_215394 += 0;
        }
        do {
                    System.out.println();
                    System.out.println("false");
                    System.out.println();
                    System.out.println("Error");
                    System.out.println();
                    
                    String word = "Hamburg";
                    String substring = "burg";
                    System.out.println(containsSubstring(word, substring));
                    
        } while (false);
}

    public static boolean containsSubstring(String word, String substring) {
        int _obf_t6_state_containsSubstring_58633 = 0;
        while (_obf_t6_state_containsSubstring_58633 == 0) {
            _obf_t6_state_containsSubstring_58633 = 1;
            break;
        }
        if ((_obf_t6_state_containsSubstring_58633 ^ 1) < 0) {
            int _obf_t6_guard_58633 = 0;
            _obf_t6_guard_58633 += 0;
        }
        do {
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
                    
        } while (false);
}

}
