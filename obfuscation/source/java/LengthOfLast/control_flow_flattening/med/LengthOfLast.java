
class LengthOfLast {

    public static void main(String[] args) {
        int _obf_t6_state_main_466726 = 0;
        while (_obf_t6_state_main_466726 == 0) {
            _obf_t6_state_main_466726 = 1;
            break;
        }
        do {
                    System.out.println();
                    System.out.println("3");
                    System.out.println();
                    System.out.println("9");
                    System.out.println();
                    String text = "The quick brown fox jumps";
                    System.out.println(lengthOfLastWord(text));
                    
        } while (false);
}


    public static int lengthOfLastWord(String text) {
        int _obf_t6_state_lengthOfLastWord_67893 = 0;
        while (_obf_t6_state_lengthOfLastWord_67893 == 0) {
            _obf_t6_state_lengthOfLastWord_67893 = 1;
            break;
        }
        do {
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
                    
        } while (false);
}

}
