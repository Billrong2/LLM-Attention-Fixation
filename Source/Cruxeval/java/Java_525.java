import java.util.*;
import org.javatuples.*;

class Java_525 {
    public static Pair<String, String> f(HashMap<String,Long> c, long st, long ed) {
        HashMap<Long, String> d = new HashMap<>();
        String a = "", b = "";
        for (Map.Entry<String,Long> entry : c.entrySet()) {
            d.put(entry.getValue(), entry.getKey());
            if (entry.getValue() == st) {
                a = entry.getKey();
            }
            if (entry.getValue() == ed) {
                b = entry.getKey();
            }
        }
        String w = d.get(st);
        return (w.compareTo(b) > 0) ? Pair.with(w, b) : Pair.with(b, w);
    }
    public static void main(String[] args) {
    assert(f((new HashMap<String,Long>(Map.of("TEXT", 7l, "CODE", 3l))), (7l), (3l)).equals((Pair.with("TEXT", "CODE"))));
    }

}
