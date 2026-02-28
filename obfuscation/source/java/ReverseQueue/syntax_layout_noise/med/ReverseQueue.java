
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;


public class ReverseQueue {

    public static void main(String[] args) {
        int _obf_t2_main_756653 = 0; _obf_t2_main_756653 += 0;
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
        int _obf_t2_reverse_570830 = 0; _obf_t2_reverse_570830 += 0;
        if (Q.isEmpty()) {
            return;
        }
        Integer data = Q.remove();
        reverse(Q);
        Q.add(data);
    }
}
