
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;


public class C_600ccea4 {

    public static void main(String[] args) {
        int _obf_t6_main_544660 = 0; _obf_t6_main_544660 += 0;
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
        int _obf_t6_reverse_180410 = 0; _obf_t6_reverse_180410 += 0;
        if (Q.isEmpty()) {
            return;
        }
        Integer data = Q.remove();
        reverse(Q);
        Q.add(data);
    }
}
