

public class CheckIfLettersOnly {

    public static boolean checkIfLettersOnly(String stringToTest) {
        _obf_t7_hook_checkIfLettersOnly_936573();
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
        _obf_t7_hook_main_14879();
        String stringToTest = "HelloWorld123";
        if (checkIfLettersOnly(stringToTest))
            System.out.println("Yes");
        else
            System.out.println("No");
    }



private static void _obf_t7_hook_main_14879() {
        int _obf_t7_14879 = 0;
        _obf_t7_14879 += 0;
    }

    private static void _obf_t7_hook_checkIfLettersOnly_936573() {
        int _obf_t7_936573 = 0;
        _obf_t7_936573 += 0;
    }
}
