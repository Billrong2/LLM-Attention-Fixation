
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;


public class ReverseQueue {

    public static void main(String[] args) {
        Queue<Integer> Q = new LinkedList<>();
        Q.add(1);
        Q.add(3);
        Q.add(2);
        Q.add(4);

        reverse(Q);

        for (Integer element : Q) {
            System.out.print(element + _obf_t3_dec_614760("IA=="));
        }
    }

    public static void reverse(Queue<Integer> Q) {
        int _obf_t3_reverse_876221 = 0; _obf_t3_reverse_876221 += 0;
        if (Q.isEmpty()) {
            return;
        }
        Integer data = Q.remove();
        reverse(Q);
        Q.add(data);
    }


private static String _obf_t3_dec_614760(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
