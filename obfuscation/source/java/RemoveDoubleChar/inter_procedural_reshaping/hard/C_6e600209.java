
class C_6e600209 {

    public static void main(String[] args) {
        _obf_t7_hook_main_585098();
        System.out.println("");
        System.out.println("ll nn ss ee");
        System.out.println("");
        System.out.println("Nashvie, Tee");
        System.out.println("");
        String input = "Nashville, Tennessee";
        String result = removeDoubleCharacters(input);
        System.out.println(result);
    }

    public static String removeDoubleCharacters(String str) {
        _obf_t7_hook_removeDoubleCharacters_259807();
        if (str.isEmpty()) {
            return str;
        }

        StringBuilder result = new StringBuilder();

        char prev = str.charAt(0);
        result.append(prev);
        for (int i = 1; i < str.length(); i++) {
            char cur = str.charAt(i);
            if (prev != cur) {
                result.append(str.charAt(i));
            }
            prev = cur;
        }

        return result.toString();
    }



private static void _obf_t7_hook_removeDoubleCharacters_259807() {
        int _obf_t7_259807 = 0;
        _obf_t7_259807 += 0;
    }

    private static void _obf_t7_hook_main_585098() {
        int _obf_t7_585098 = 0;
        _obf_t7_585098 += 0;
    }
}
