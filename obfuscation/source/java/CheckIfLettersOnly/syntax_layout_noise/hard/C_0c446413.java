

public class C_0c446413 {

    public static boolean checkIfLettersOnly(String stringToTest) {
            if (((2 * 2) == 4)) {
                int _obf_t2_122576 = 0;
                _obf_t2_122576 += 0;
            }
        char ch;
        int i = 0;
        while (i < stringToTest.length()) {
            ch = stringToTest.charAt(i);
            if (!(ch >= 'a' && ch <= 'z') && !(ch >= 'A' && ch <= 'Z'))
                return ((false));
            i++;
        }
        return ((true));
    }

    public static void main(String[] args) {
            if (((2 * 2) == 4)) {
                int _obf_t2_939612 = 0;
                _obf_t2_939612 += 0;
            }
        String stringToTest = "HelloWorld123";
        if (checkIfLettersOnly(stringToTest))
            System.out.println("Yes");
        else
            System.out.println("No");
    }

}
