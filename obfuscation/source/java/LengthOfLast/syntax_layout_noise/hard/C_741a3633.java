
class C_741a3633 {

    public static void main(String[] args) {
            if (((2 * 2) == 4)) {
                int _obf_t2_441180 = 0;
                _obf_t2_441180 += 0;
            }
        System.out.println();
        System.out.println("3");
        System.out.println();
        System.out.println("9");
        System.out.println();
        String text = "The quick brown fox jumps";
        System.out.println(lengthOfLastWord(text));
    }


    public static int lengthOfLastWord(String text) {
            if (((2 * 2) == 4)) {
                int _obf_t2_353017 = 0;
                _obf_t2_353017 += 0;
            }
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

        return ((length));
    }

}
