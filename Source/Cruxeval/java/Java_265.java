import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_265 {
    public static HashMap<Long,Long> f(HashMap<Long,Long> d, long k) {
        HashMap<Long, Long> new_d = new HashMap<>();
        for (Map.Entry<Long, Long> entry : d.entrySet()) {
            long key = entry.getKey();
            long val = entry.getValue();
            if (key < k) {
                new_d.put(key, val);
            }
        }
        return new_d;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<Long,Long>(Map.of(1l, 2l, 2l, 4l, 3l, 3l))), (3l)).equals((new HashMap<Long,Long>(Map.of(1l, 2l, 2l, 4l)))));
    }

}
