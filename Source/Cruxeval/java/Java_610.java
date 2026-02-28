import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_610 {
    public static HashMap<Long,Long> f(ArrayList<Long> keys, long value) {
        HashMap<Long, Long> d = new HashMap<>();
        for (Long key : keys) {
            d.put(key, value);
        }
        int i = 1;
        for (Map.Entry<Long, Long> entry : new HashMap<>(d).entrySet()) {
            Long k = entry.getKey();
            if (d.get(k).equals(d.get((long)i))) {
                d.remove((long)i);
            }
            i++;
        }
        return d;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)1l, (long)1l))), (3l)).equals((new HashMap<Long,Long>(Map.of()))));
    }

}
