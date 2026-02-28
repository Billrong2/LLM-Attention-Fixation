
import java.util.Arrays;
import java.util.List;

class C_5cf3deac {

    public static void main(String[] p_0O0IO1) {
        System.out.println();
        System.out.println("[12, 11, 9, 8]");
        System.out.println();
        System.out.println("[11, 9, 12, 8]");
        System.out.println();
        int _IlIOl1 = 9;
        int _010O02 = 12;
        int _IlO1I3 = 8;
        int _11lOI4 = 11;
        System.out.println(sort(_IlIOl1, _010O02, _IlO1I3, _11lOI4));
    }

    public static List<Integer> sort(int p_O100O1, int p_IIl0l2, int p_0Il0I3, int p_OIIll4) {
        if (p_O100O1 > p_IIl0l2) {
            int _IlO0l1 = p_IIl0l2;
            p_IIl0l2 = p_O100O1;
            p_O100O1 = _IlO0l1;
        }
        if (p_0Il0I3 > p_OIIll4) {
            int _IlO0l1 = p_OIIll4;
            p_OIIll4 = p_0Il0I3;
            p_0Il0I3 = _IlO0l1;
        }
        if (p_O100O1 > p_0Il0I3) {
            int _IlO0l1 = p_0Il0I3;
            p_0Il0I3 = p_O100O1;
            p_O100O1 = _IlO0l1;
        }
        if (p_IIl0l2 > p_OIIll4) {
            int _IlO0l1 = p_OIIll4;
            p_OIIll4 = p_IIl0l2;
            p_IIl0l2 = _IlO0l1;
        }
        if (p_IIl0l2 > p_0Il0I3) {
            int _IlO0l1 = p_0Il0I3;
            p_0Il0I3 = p_IIl0l2;
            p_IIl0l2 = _IlO0l1;
        }

        return Arrays.asList(p_O100O1, p_IIl0l2, p_0Il0I3, p_OIIll4);
    }

}
