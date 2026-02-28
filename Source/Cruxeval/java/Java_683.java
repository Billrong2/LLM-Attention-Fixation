import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_683 {
    public static HashMap<String,Long> f(HashMap<String,Long> dict1, HashMap<String,Long> dict2) {
        HashMap<String, Long> result = new HashMap<>(dict1);
        for (String key : dict2.keySet()) {
            result.put(key, dict2.get(key));
        }
        return result;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<String,Long>(Map.of("disface", 9l, "cam", 7l))), (new HashMap<String,Long>(Map.of("mforce", 5l)))).equals((new HashMap<String,Long>(Map.of("disface", 9l, "cam", 7l, "mforce", 5l)))));
    }

}
