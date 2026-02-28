
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;


public class C_825b519d {

    public static void main(String[] args) {
        Queue<Integer> Q = new LinkedList<>();
        Q.add((((1) ^ 52) ^ 52));
        Q.add((((3) ^ 10) ^ 10));
        Q.add((((2) ^ 27) ^ 27));
        Q.add((((4) ^ 10) ^ 10));

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
