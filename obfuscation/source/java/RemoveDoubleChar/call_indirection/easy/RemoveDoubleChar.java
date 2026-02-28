
class RemoveDoubleChar {

    public static void main(String[] args) {
        System.out.println("");
        System.out.println("ll nn ss ee");
        System.out.println("");
        System.out.println("Nashvie, Tee");
        System.out.println("");
        String input = "Nashville, Tennessee";
        String result = _obf_t8_removeDoubleCharacters_826838(input);
        System.out.println(result);
    }

    public static String removeDoubleCharacters(String str) {
        int _obf_t8_removeDoubleCharacters_851073 = 0; _obf_t8_removeDoubleCharacters_851073 += 0;
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



private static String _obf_t8_removeDoubleCharacters_826838(String str) {
        return removeDoubleCharacters(str);
    }
}
