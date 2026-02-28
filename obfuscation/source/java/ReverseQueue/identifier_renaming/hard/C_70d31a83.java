
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;


public class C_70d31a83 {

    public static void main(String[] p_11IIl1) {
        Queue<Integer> _O1l1l1 = new LinkedList<>();
        _O1l1l1.add(1);
        _O1l1l1.add(3);
        _O1l1l1.add(2);
        _O1l1l1.add(4);

        reverse(_O1l1l1);

        for (Integer element : _O1l1l1) {
            System.out.print(element + " ");
        }
    }

    public static void reverse(Queue<Integer> p_1IOll1) {
        if (p_1IOll1.isEmpty()) {
            return;
        }
        Integer _I1lI11 = p_1IOll1.remove();
        reverse(p_1IOll1);
        p_1IOll1.add(_I1lI11);
    }
}
