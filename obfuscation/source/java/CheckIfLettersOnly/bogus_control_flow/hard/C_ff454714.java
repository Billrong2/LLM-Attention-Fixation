

public class C_ff454714 {

    public static boolean checkIfLettersOnly(String stringToTest) {
        int _obf_t5_checkIfLettersOnly_515011 = 0; _obf_t5_checkIfLettersOnly_515011 += 0;
        char ch;
        int i = 0;
        while (i < stringToTest.length()) {
            ch = stringToTest.charAt(i);
            if (!(ch >= 'a' && ch <= 'z') && !(ch >= 'A' && ch <= 'Z'))
                return false;
            i++;
        }
        return true;
    }

    public static void main(String[] args) {
        int _obf_t5_main_564971 = 0; _obf_t5_main_564971 += 0;
        String stringToTest = "HelloWorld123";
        if (checkIfLettersOnly(stringToTest))
            System.out.println("Yes");
        else
            System.out.println("No");
    }

}
