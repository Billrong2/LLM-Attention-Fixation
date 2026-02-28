import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_396 {
    public static HashMap<Long,Long> f(HashMap<Long,Long> ets) {
        if (ets.size() == 0) {
            return ets;
        }
        Iterator<Map.Entry<Long, Long>> it = ets.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry<Long, Long> pair = it.next();
            ets.put(pair.getKey(), (long) Math.pow(pair.getValue(), 2));
            it.remove(); // avoids a ConcurrentModificationException
        }
        return ets;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<Long,Long>(Map.of()))).equals((new HashMap<Long,Long>(Map.of()))));
    }

}
