
class C_37811266 {

    public static void main(String[] args) {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_main_433524 = 0;
            _obf_t5_main_433524++;
        }
        if (((2 * 2) + 1) > 0) {
            int _obf_t5_main_433524_m = 0;
            _obf_t5_main_433524_m += 0;
        } else {
            int _obf_t5_main_433524_e = 1;
            _obf_t5_main_433524_e -= 1;
        }
        int _obf_t5_main_433524_h = (1 ^ 1);
        if (_obf_t5_main_433524_h != 0) {
            _obf_t5_main_433524_h += 1;
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
        int _obf_t5_lengthOfLastWord_826373 = 0; _obf_t5_lengthOfLastWord_826373 += 0;
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

}
