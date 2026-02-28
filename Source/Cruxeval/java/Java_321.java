import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_321 {
    public static HashMap<String,Long> f(HashMap<String,Long> update, HashMap<String,Long> starting) {
        HashMap<String, Long> d = new HashMap<>(starting);
        for (String k : update.keySet()) {
            if (d.containsKey(k)) {
                d.put(k, d.get(k) + update.get(k));
            } else {
                d.put(k, update.get(k));
            }
        }
        return d;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<String,Long>()), (new HashMap<String,Long>(Map.of("desciduous", 2l)))).equals((new HashMap<String,Long>(Map.of("desciduous", 2l)))));
    }

}
