import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_524 {
    public static HashMap<Long,Long> f(HashMap<Long,Long> dict0) {
        HashMap<Long,Long> newMap = new HashMap<>(dict0);
        List<Long> keys = new ArrayList<>(newMap.keySet());
        Collections.sort(keys);
        for (int i = 0; i < keys.size() - 1; i++) {
            newMap.put(keys.get(i), (long) i);
        }
        return newMap;    }
    public static void main(String[] args) {
    assert(f((new HashMap<Long,Long>(Map.of(2l, 5l, 4l, 1l, 3l, 5l, 1l, 3l, 5l, 1l)))).equals((new HashMap<Long,Long>(Map.of(2l, 1l, 4l, 3l, 3l, 2l, 1l, 0l, 5l, 1l)))));
    }

}
