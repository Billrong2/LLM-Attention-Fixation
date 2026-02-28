
import java.util.Random;

public class C_3444fdb6 {

    public static void main(String[] p_OII111) {
        int[] field = {23, 42, 137, 12, 54};
        int[] result = bogo(field);
        for (int element : result) {
            System.out.print(element + " ");
        }
    }

    public static int[] bogo(int[] p_O1OIO1) {
        Random _lO11l1 = new Random();

        while (!isFinished(p_O1OIO1)) {
            int _Ol11O2 = _lO11l1.nextInt(p_O1OIO1.length);
            int _100003 = _lO11l1.nextInt(p_O1OIO1.length);

            int _1OOI04 = p_O1OIO1[_Ol11O2];
            p_O1OIO1[_Ol11O2] = p_O1OIO1[_100003];
            p_O1OIO1[_100003] = _1OOI04;
        }

        return p_O1OIO1;
    }

    public static boolean isFinished(int[] p_lII011) {
        for (int _Oll1O1 = 0; _Oll1O1 < p_lII011.length - 1; _Oll1O1++) {
            if (p_lII011[_Oll1O1] > p_lII011[_Oll1O1 + 1]) {
                return false;
            }
        }
        return true;
    }

}
