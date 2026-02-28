import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_612 {
    public static HashMap<String,Long> f(HashMap<String,Long> d) {
        return new HashMap<>(d);
    }
    public static void main(String[] args) {
    assert(f((new HashMap<String,Long>(Map.of("a", 42l, "b", 1337l, "c", -1l, "d", 5l)))).equals((new HashMap<String,Long>(Map.of("a", 42l, "b", 1337l, "c", -1l, "d", 5l)))));
    }

}
