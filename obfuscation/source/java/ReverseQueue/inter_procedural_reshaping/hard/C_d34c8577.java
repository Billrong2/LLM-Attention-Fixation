
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;


public class C_d34c8577 {

    public static void main(String[] args) {
        _obf_t7_hook_main_22991();
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
        _obf_t7_hook_reverse_360001();
        if (Q.isEmpty()) {
            return;
        }
        Integer data = Q.remove();
        reverse(Q);
        Q.add(data);
    }


private static void _obf_t7_hook_reverse_360001() {
        int _obf_t7_360001 = 0;
        _obf_t7_360001 += 0;
    }

    private static void _obf_t7_hook_main_22991() {
        int _obf_t7_22991 = 0;
        _obf_t7_22991 += 0;
    }
}
