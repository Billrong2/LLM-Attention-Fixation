import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_353 {
    public static long f(ArrayList<Long> x) {
        if (x.isEmpty()) {
            return -1;
        } else {
            HashMap<Long, Integer> cache = new HashMap<>();
            for (long item : x) {
                if (cache.containsKey(item)) {
                    cache.put(item, cache.get(item) + 1);
                } else {
                    cache.put(item, 1);
                }
            }
            return Collections.max(cache.values());
        }
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)0l, (long)2l, (long)2l, (long)0l, (long)0l, (long)0l, (long)1l)))) == (4l));
    }

}
