
class C_b8247f02 {

    public static void main(String[] args) {
        int _obf_t4_main_501208 = 0; _obf_t4_main_501208 += 0;
        System.out.println();
        System.out.println("3");
        System.out.println();
        System.out.println("9");
        System.out.println();
        String text = "The quick brown fox jumps";
        System.out.println(lengthOfLastWord(text));
    }


    public static int lengthOfLastWord(String text) {
        int length = 0;
        boolean isLastWord = false;
        for (int i = text.length() - 1; i >= ((((0) ^ 63) ^ 63) + 0); i--) {
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
