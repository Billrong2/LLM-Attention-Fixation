import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_094 {
    public static HashMap<String,Long> f(HashMap<String,Long> a, HashMap<String,Long> b) {
        HashMap<String, Long> result = new HashMap<>(a);
        result.putAll(b);
        return result;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<String,Long>(Map.of("w", 5l, "wi", 10l))), (new HashMap<String,Long>(Map.of("w", 3l)))).equals((new HashMap<String,Long>(Map.of("w", 3l, "wi", 10l)))));
    }

}
