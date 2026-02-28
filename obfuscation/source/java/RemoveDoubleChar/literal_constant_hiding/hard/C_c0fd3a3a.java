
class C_c0fd3a3a {

    public static void main(String[] args) {
        System.out.println(_obf_t3_dec_824337(""));
        System.out.println(_obf_t3_dec_824337("bGwgbm4gc3MgZWU="));
        System.out.println(_obf_t3_dec_824337(""));
        System.out.println(_obf_t3_dec_824337("TmFzaHZpZSwgVGVl"));
        System.out.println(_obf_t3_dec_824337(""));
        String input = _obf_t3_dec_824337("TmFzaHZpbGxlLCBUZW5uZXNzZWU=");
        String result = removeDoubleCharacters(input);
        System.out.println(result);
    }

    public static String removeDoubleCharacters(String str) {
        if (str.isEmpty()) {
            return str;
        }

        StringBuilder result = new StringBuilder();

        char prev = str.charAt((((0) ^ 43) ^ 43));
        result.append(prev);
        for (int i = (((1) ^ 6) ^ 6); i < str.length(); i++) {
            char cur = str.charAt(i);
            if (prev != cur) {
                result.append(str.charAt(i));
            }
            prev = cur;
        }

        return result.toString();
    }



private static String _obf_t3_dec_824337(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
