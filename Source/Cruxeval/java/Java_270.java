import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_270 {
    public static HashMap<Long,Long> f(HashMap<Long,Long> dic) {
        HashMap<Long, Long> d = new HashMap<>();
        Iterator<Map.Entry<Long, Long>> iterator = dic.entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry<Long, Long> entry = iterator.next();
            d.put(entry.getKey(), entry.getValue());
            iterator.remove();
        }
        return d;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<Long,Long>(Map.of()))).equals((new HashMap<Long,Long>(Map.of()))));
    }

}
