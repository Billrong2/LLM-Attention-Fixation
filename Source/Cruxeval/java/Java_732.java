import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_732 {
    public static HashMap<String,Long> f(HashMap<String,Long> char_freq) {
        HashMap<String, Long> result = new HashMap<>();
        for (Map.Entry<String, Long> entry : new HashMap<>(char_freq).entrySet()) {
            result.put(entry.getKey(), entry.getValue() / 2);
        }
        return result;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<String,Long>(Map.of("u", 20l, "v", 5l, "b", 7l, "w", 3l, "x", 3l)))).equals((new HashMap<String,Long>(Map.of("u", 10l, "v", 2l, "b", 3l, "w", 1l, "x", 1l)))));
    }

}
