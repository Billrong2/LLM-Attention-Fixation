
class LengthOfLast {

    public static void main(String[] args) {
        System.out.println();
        System.out.println("3");
        System.out.println();
        System.out.println("9");
        System.out.println();
        String v1 = "The quick brown fox jumps";
        System.out.println(lengthOfLastWord(v1));
    }


    public static int lengthOfLastWord(String text) {
        int v1 = 0;
        boolean v2 = false;
        for (int v3 = text.length() - 1; v3 >= 0; v3--) {
            char v4 = text.charAt(v3);
            if ((v4 >= 'a' && v4 <= 'z') || (v4 >= 'A' && v4 <= 'Z')) {
                v2 = true;
                v1++;
            } else {
                if (v2) {
                    break;
                }
            }
        }

        return v1;
    }

}
