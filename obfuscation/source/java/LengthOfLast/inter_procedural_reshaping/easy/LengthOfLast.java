
class LengthOfLast {

    public static void main(String[] args) {
        _obf_t7_hook_main_499361();
        System.out.println();
        System.out.println("3");
        System.out.println();
        System.out.println("9");
        System.out.println();
        String text = "The quick brown fox jumps";
        System.out.println(lengthOfLastWord(text));
    }


    public static int lengthOfLastWord(String text) {
        _obf_t7_hook_lengthOfLastWord_388325();
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



private static void _obf_t7_hook_lengthOfLastWord_388325() {
        int _obf_t7_388325 = 0;
        _obf_t7_388325 += 0;
    }

    private static void _obf_t7_hook_main_499361() {
        int _obf_t7_499361 = 0;
        _obf_t7_499361 += 0;
    }
}
