import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_025 {
    public static HashMap<String,Long> f(HashMap<String,Long> d) {
        HashMap<String, Long> newMap = new HashMap<>(d);
        newMap.remove(newMap.keySet().iterator().next());
        return newMap;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<String,Long>(Map.of("l", 1l, "t", 2l, "x:", 3l)))).equals((new HashMap<String,Long>(Map.of("l", 1l, "t", 2l)))));
    }

}
