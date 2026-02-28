
class LengthOfLast {

    public static void main(String[] args) {
        System.out.println();
        System.out.println(_obf_t3_dec_99626("Mw=="));
        System.out.println();
        System.out.println(_obf_t3_dec_99626("OQ=="));
        System.out.println();
        String text = _obf_t3_dec_99626("VGhlIHF1aWNrIGJyb3duIGZveCBqdW1wcw==");
        System.out.println(lengthOfLastWord(text));
    }


    public static int lengthOfLastWord(String text) {
        int _obf_t3_lengthOfLastWord_495524 = 0; _obf_t3_lengthOfLastWord_495524 += 0;
        int length = 0;
        boolean isLastWord = false;
        for (int i = text.length() - 1; i >= 0; i--) {
            char c = text.charAt(i);
            if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')) {
                isLastWord = true;
                length++;
            } else {
                if (isLastWord) {
                    break;
                }
            }
        }

        return length;
    }



private static String _obf_t3_dec_99626(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
