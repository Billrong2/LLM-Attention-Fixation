import java.util.*;
import org.javatuples.*;

class Java_577 {
    public static ArrayList<HashMap<Long,Long>> f(ArrayList<Pair<Long, String>> items) {
        ArrayList<HashMap<Long,Long>> result = new ArrayList<>();
        for (Pair<Long, String> number : items) {
            HashMap<Long, Long> d = new HashMap<>();
            for (Pair<Long, String> pair : items) {
                d.put(pair.getValue0(), pair.getValue0());
            }
            Iterator<Map.Entry<Long, Long>> iterator = d.entrySet().iterator();
            if (iterator.hasNext()) {
                iterator.next();
                iterator.remove();
            }
            result.add(d);
        }
        return result;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Pair<Long, String>>(Arrays.asList((Pair<Long, String>)Pair.with(1l, "pos"))))).equals((new ArrayList<HashMap<Long,Long>>(Arrays.asList((HashMap<Long,Long>)new HashMap<Long,Long>(Map.of()))))));
    }

}
