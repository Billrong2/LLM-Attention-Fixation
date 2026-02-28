

public class CheckIfLettersOnly {

    public static boolean checkIfLettersOnly(String stringToTest) {
        char v1;
        int v2 = 0;
        while (v2 < stringToTest.length()) {
            v1 = stringToTest.charAt(v2);
            if (!(v1 >= 'a' && v1 <= 'z') && !(v1 >= 'A' && v1 <= 'Z'))
                return false;
            v2++;
        }
        return true;
    }

    public static void main(String[] args) {
        String v1 = "HelloWorld123";
        if (checkIfLettersOnly(v1))
            System.out.println("Yes");
        else
            System.out.println("No");
    }

}
