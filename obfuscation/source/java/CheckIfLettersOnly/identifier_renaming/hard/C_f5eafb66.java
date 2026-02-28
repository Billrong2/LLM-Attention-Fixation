

public class C_f5eafb66 {

    public static boolean checkIfLettersOnly(String p_l01IO1) {
        char _lI0O01;
        int _I0lOO2 = 0;
        while (_I0lOO2 < p_l01IO1.length()) {
            _lI0O01 = p_l01IO1.charAt(_I0lOO2);
            if (!(_lI0O01 >= 'a' && _lI0O01 <= 'z') && !(_lI0O01 >= 'A' && _lI0O01 <= 'Z'))
                return false;
            _I0lOO2++;
        }
        return true;
    }

    public static void main(String[] p_IIOI11) {
        String _00I1I1 = "HelloWorld123";
        if (checkIfLettersOnly(_00I1I1))
            System.out.println("Yes");
        else
            System.out.println("No");
    }

}
