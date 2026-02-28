
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;


public class ReverseQueue {

    public static void main(String[] args) {
        Queue<Integer> v1 = new LinkedList<>();
        v1.add(1);
        v1.add(3);
        v1.add(2);
        v1.add(4);

        reverse(v1);

        for (Integer element : v1) {
            System.out.print(element + " ");
        }
    }

    public static void reverse(Queue<Integer> Q) {
        if (Q.isEmpty()) {
            return;
        }
        Integer v1 = Q.remove();
        reverse(Q);
        Q.add(v1);
    }
}
