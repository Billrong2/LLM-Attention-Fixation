import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_095 {
    public static HashMap<String,String> f(HashMap<String,String> zoo) {
        HashMap<String, String> result = new HashMap<>();
        for (Map.Entry<String, String> entry : zoo.entrySet()) {
            result.put(entry.getValue(), entry.getKey());
        }
        return result;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<String,String>(Map.of("AAA", "fr")))).equals((new HashMap<String,String>(Map.of("fr", "AAA")))));
    }

}
