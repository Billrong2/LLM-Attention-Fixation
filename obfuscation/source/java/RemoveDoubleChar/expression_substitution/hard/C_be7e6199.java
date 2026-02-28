
class C_be7e6199 {

    public static void main(String[] args) {
        int _obf_t4_main_270155 = 0; _obf_t4_main_270155 += 0;
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
        if (str.isEmpty()) {
            return str;
        }

        StringBuilder result = new StringBuilder();

        char prev = str.charAt(0);
        result.append(prev);
        for (int i = ((((1) ^ 42) ^ 42) + 0); i < str.length(); i++) {
            char cur = str.charAt(i);
            if (prev != cur) {
                result.append(str.charAt(i));
            }
            prev = cur;
        }

        return result.toString();
    }

}
