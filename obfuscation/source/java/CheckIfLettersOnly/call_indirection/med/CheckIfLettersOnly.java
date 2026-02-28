

public class CheckIfLettersOnly {

    public static boolean checkIfLettersOnly(String stringToTest) {
        int _obf_t8_checkIfLettersOnly_799420 = 0; _obf_t8_checkIfLettersOnly_799420 += 0;
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
        String stringToTest = "HelloWorld123";
        if (_obf_t8_checkIfLettersOnly_461109(stringToTest))
            System.out.println("Yes");
        else
            System.out.println("No");
    }



private static boolean _obf_t8_checkIfLettersOnly_461109(String stringToTest) {
        int _obf_sel = 1;
        switch (_obf_sel) {
            case 1: return checkIfLettersOnly(stringToTest);
            default: return checkIfLettersOnly(stringToTest);
        }
    }
}
