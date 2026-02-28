

class ContainsSubstring {

    public static void main(String[] args) {
        System.out.println();
        System.out.println("false");
        System.out.println();
        System.out.println("Error");
        System.out.println();

        String v1 = "Hamburg";
        String v2 = "burg";
        System.out.println(containsSubstring(v1, v2));
    }

    public static boolean containsSubstring(String word, String substring) {
        boolean v1 = false;

        for (int v2 = 0; v2 < word.length(); v2++) {
            for (int v3 = 0; v3 < substring.length(); v3++) {
                if (v2 + v3 > word.length()) {
                    break;
                }
                if (word.charAt(v2 + v3) != substring.charAt(v3)) {
                    break;
                } else {
                    if (v3 == substring.length() - 1) {
                        v1 = true;
                        break;
                    }
                }
            }
        }

        return v1;
    }

}
