import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
import org.javatuples.*;
import org.javatuples.Pair;

class Java_784 {
    public static Pair<String, String> f(String key, String value) {
        Map<String, String> dict_ = new HashMap<>();
        dict_.put(key, value);
        Map.Entry<String, String> entry = dict_.entrySet().iterator().next();
        return new Pair<>(entry.getKey(), entry.getValue());
    }
    public static void main(String[] args) {
    assert(f(("read"), ("Is")).equals((Pair.with("read", "Is"))));
    }

}
