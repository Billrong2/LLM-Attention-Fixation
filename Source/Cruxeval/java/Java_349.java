import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_349 {
    public static HashMap<String,Long> f(HashMap<String,Long> dictionary) {
        dictionary.put("1049", 55l);
        Map.Entry<String,Long> entry = dictionary.entrySet().iterator().next();
        dictionary.remove(entry.getKey());
        dictionary.put(entry.getKey(), entry.getValue());
        return dictionary;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<String,Long>(Map.of("noeohqhk", 623l)))).equals((new HashMap<String,Long>(Map.of("noeohqhk", 623l, "1049", 55l)))));
    }

}
