import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_578 {
    public static HashMap<String,Long> f(HashMap<String,Long> obj) {
        for (Map.Entry<String, Long> entry : obj.entrySet()) {
            if (entry.getValue() >= 0) {
                obj.put(entry.getKey(), -entry.getValue());
            }
        }
        return obj;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<String,Long>(Map.of("R", 0l, "T", 3l, "F", -6l, "K", 0l)))).equals((new HashMap<String,Long>(Map.of("R", 0l, "T", -3l, "F", -6l, "K", 0l)))));
    }

}
