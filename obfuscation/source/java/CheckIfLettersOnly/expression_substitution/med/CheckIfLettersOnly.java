

public class CheckIfLettersOnly {

    public static boolean checkIfLettersOnly(String stringToTest) {
        char ch;
        int i = 0;
        while (i < stringToTest.length()) {
            ch = stringToTest.charAt(i);
            if (!(ch >= 'a' && ch <= 'z') && !(ch >= 'A' && ch <= 'Z'))
                return (((((1) ^ 14) ^ 14) ^ 0) != (((1) ^ 4) ^ 4));
            i++;
        }
        return ((1 ^ 0) == 1);
    }

    public static void main(String[] args) {
        int _obf_t4_main_992892 = 0; _obf_t4_main_992892 += 0;
        String stringToTest = "HelloWorld123";
        if (checkIfLettersOnly(stringToTest))
            System.out.println("Yes");
        else
            System.out.println("No");
    }

}
