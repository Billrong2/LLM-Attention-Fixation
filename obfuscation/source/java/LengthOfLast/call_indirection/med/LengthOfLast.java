
class LengthOfLast {

    public static void main(String[] args) {
        System.out.println();
        System.out.println("3");
        System.out.println();
        System.out.println("9");
        System.out.println();
        String text = "The quick brown fox jumps";
        System.out.println(_obf_t8_lengthOfLastWord_614927(text));
    }


    public static int lengthOfLastWord(String text) {
        int _obf_t8_lengthOfLastWord_656311 = 0; _obf_t8_lengthOfLastWord_656311 += 0;
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



private static int _obf_t8_lengthOfLastWord_614927(String text) {
        int _obf_sel = 2;
        switch (_obf_sel) {
            case 2: return lengthOfLastWord(text);
            default: return lengthOfLastWord(text);
        }
    }
}
