

public class CheckIfLettersOnly {

    public static boolean checkIfLettersOnly(String stringToTest) {
        int _obf_t6_checkIfLettersOnly_909544 = 0; _obf_t6_checkIfLettersOnly_909544 += 0;
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
        int _obf_t6_state_main_710330 = 0;
        while (_obf_t6_state_main_710330 == 0) {
            _obf_t6_state_main_710330 = 1;
            break;
        }
        do {
                    String stringToTest = "HelloWorld123";
                    if (checkIfLettersOnly(stringToTest))
                    System.out.println("Yes");
                    else
                    System.out.println("No");
                    
        } while (false);
}

}
