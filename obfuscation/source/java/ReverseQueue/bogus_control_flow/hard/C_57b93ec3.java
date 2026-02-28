
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;


public class C_57b93ec3 {

    public static void main(String[] args) {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_main_233152 = 0;
            _obf_t5_main_233152++;
        }
        if (((2 * 2) + 1) > 0) {
            int _obf_t5_main_233152_m = 0;
            _obf_t5_main_233152_m += 0;
        } else {
            int _obf_t5_main_233152_e = 1;
            _obf_t5_main_233152_e -= 1;
        }
        int _obf_t5_main_233152_h = (1 ^ 1);
        if (_obf_t5_main_233152_h != 0) {
            _obf_t5_main_233152_h += 1;
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
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_reverse_257766 = 0;
            _obf_t5_reverse_257766++;
        }
        if (((2 * 2) + 1) > 0) {
            int _obf_t5_reverse_257766_m = 0;
            _obf_t5_reverse_257766_m += 0;
        } else {
            int _obf_t5_reverse_257766_e = 1;
            _obf_t5_reverse_257766_e -= 1;
        }
        int _obf_t5_reverse_257766_h = (1 ^ 1);
        if (_obf_t5_reverse_257766_h != 0) {
            _obf_t5_reverse_257766_h += 1;
        }
        if (Q.isEmpty()) {
            return;
        }
        Integer data = Q.remove();
        reverse(Q);
        Q.add(data);
    }
}
