import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_071 {
    public static HashMap<Long,Long> f(HashMap<Long,Long> d, long n) {
        for (long i = 0; i < n; i++) {
            Map.Entry<Long, Long> item = d.entrySet().iterator().next();
            d.remove(item.getKey());
            d.put(item.getValue(), item.getKey());
        }
        return d;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<Long,Long>(Map.of(1l, 2l, 3l, 4l, 5l, 6l, 7l, 8l, 9l, 10l))), (1l)).equals((new HashMap<Long,Long>(Map.of(1l, 2l, 3l, 4l, 5l, 6l, 7l, 8l, 10l, 9l)))));
    }

}
