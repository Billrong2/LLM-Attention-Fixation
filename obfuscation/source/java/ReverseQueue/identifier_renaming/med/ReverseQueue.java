
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;


public class ReverseQueue {

    public static void main(String[] _p1) {
        Queue<Integer> _o1 = new LinkedList<>();
        _o1.add(1);
        _o1.add(3);
        _o1.add(2);
        _o1.add(4);

        reverse(_o1);

        for (Integer element : _o1) {
            System.out.print(element + " ");
        }
    }

    public static void reverse(Queue<Integer> _p1) {
        if (_p1.isEmpty()) {
            return;
        }
        Integer _o1 = _p1.remove();
        reverse(_p1);
        _p1.add(_o1);
    }
}
