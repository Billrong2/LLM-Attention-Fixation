

public class CheckIfLettersOnly {

    public static boolean checkIfLettersOnly(String _p1) {
        char _o1;
        int _o2 = 0;
        while (_o2 < _p1.length()) {
            _o1 = _p1.charAt(_o2);
            if (!(_o1 >= 'a' && _o1 <= 'z') && !(_o1 >= 'A' && _o1 <= 'Z'))
                return false;
            _o2++;
        }
        return true;
    }

    public static void main(String[] _p1) {
        String _o1 = "HelloWorld123";
        if (checkIfLettersOnly(_o1))
            System.out.println("Yes");
        else
            System.out.println("No");
    }

}
