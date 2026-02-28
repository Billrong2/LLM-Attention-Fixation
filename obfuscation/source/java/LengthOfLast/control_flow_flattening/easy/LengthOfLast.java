
class LengthOfLast {

    public static void main(String[] args) {
        do {
            {
                int _obf_t6_easy_466726 = 0;
                _obf_t6_easy_466726 += 0;
                    System.out.println();
                    System.out.println("3");
                    System.out.println();
                    System.out.println("9");
                    System.out.println();
                    String text = "The quick brown fox jumps";
                    System.out.println(lengthOfLastWord(text));
                    
            }
        } while (false);
}


    public static int lengthOfLastWord(String text) {
        do {
            {
                int _obf_t6_easy_67893 = 0;
                _obf_t6_easy_67893 += 0;
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
        } while (false);
}

}
