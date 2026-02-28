

public class CheckIfLettersOnly {

    public static boolean checkIfLettersOnly(String stringToTest) {
        do {
            {
                int _obf_t6_easy_68092 = 0;
                _obf_t6_easy_68092 += 0;
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
        } while (false);
}

    public static void main(String[] args) {
        do {
            {
                int _obf_t6_easy_710330 = 0;
                _obf_t6_easy_710330 += 0;
                    String stringToTest = "HelloWorld123";
                    if (checkIfLettersOnly(stringToTest))
                    System.out.println("Yes");
                    else
                    System.out.println("No");
                    
            }
        } while (false);
}

}
