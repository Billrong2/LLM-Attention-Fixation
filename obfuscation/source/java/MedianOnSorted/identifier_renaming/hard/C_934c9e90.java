
public class C_934c9e90 {
    public static void main(String[] p_I0IO01) {
        int[] array = {1, 2, 4, 5, 6, 16};

        System.out.println(median(array));
    }

    public static float median(int[] p_1I1lO1) {
        float _10I0l1;
        if (p_1I1lO1.length % 2 == 1)
            _10I0l1 = p_1I1lO1[p_1I1lO1.length / 2];
        else
            _10I0l1 = (p_1I1lO1[p_1I1lO1.length / 2 - 1] + p_1I1lO1[p_1I1lO1.length / 2]) / 2f;
        return _10I0l1;
    }
}
