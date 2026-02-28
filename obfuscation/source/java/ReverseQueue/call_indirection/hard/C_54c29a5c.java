
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;


public class C_54c29a5c {

    public static void main(String[] args) {
        Queue<Integer> Q = new LinkedList<>();
        Q.add(1);
        Q.add(3);
        Q.add(2);
        Q.add(4);

        _obf_t8_reverse_679363(Q);

        for (Integer element : Q) {
            System.out.print(element + " ");
        }
    }

    public static void reverse(Queue<Integer> Q) {
        if (Q.isEmpty()) {
            return;
        }
        Integer data = Q.remove();
        _obf_t8_reverse_679363(Q);
        Q.add(data);
    }


private static void _obf_t8_reverse_679363(Queue<Integer> Q) {
        _obf_t8_reverse_679363_inner(Q);
    }

    private static void _obf_t8_reverse_679363_inner(Queue<Integer> Q) {
        reverse(Q);
    }
}
