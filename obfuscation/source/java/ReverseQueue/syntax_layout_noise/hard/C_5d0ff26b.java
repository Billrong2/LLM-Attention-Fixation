
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;


public class C_5d0ff26b {

    public static void main(String[] args) {
            if (((2 * 2) == 4)) {
                int _obf_t2_619182 = 0;
                _obf_t2_619182 += 0;
            }
        Queue<Integer> Q = new LinkedList<>();
        Q.add(1);
        Q.add(3);
        Q.add(2);
        Q.add(4);

        reverse(Q);

        for (Integer element : Q) {
            System.out.print(element + " ");
        }
    }

    public static void reverse(Queue<Integer> Q) {
            if (((2 * 2) == 4)) {
                int _obf_t2_213086 = 0;
                _obf_t2_213086 += 0;
            }
        if (Q.isEmpty()) {
            return;
        }
        Integer data = Q.remove();
        reverse(Q);
        Q.add(data);
    }
}
