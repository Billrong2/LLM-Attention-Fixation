import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_636 {
    public static HashMap<Long,String> f(HashMap<Long,String> d) {
        HashMap<Long, String> r = new HashMap<>();
        while (d.size() > 0) {
            r.putAll(d);
            d.remove(Collections.max(d.keySet()));
        }
        return r;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<Long,String>(Map.of(3l, "A3", 1l, "A1", 2l, "A2")))).equals((new HashMap<Long,String>(Map.of(3l, "A3", 1l, "A1", 2l, "A2")))));
    }

}
