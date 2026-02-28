import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_338 {
    public static HashMap<Long,String> f(HashMap<String,Long> my_dict) {
        HashMap<Long, String> result = new HashMap<>();
        for (Map.Entry<String, Long> entry : my_dict.entrySet()) {
            result.put(entry.getValue(), entry.getKey());
        }
        return result;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<String,Long>(Map.of("a", 1l, "b", 2l, "c", 3l, "d", 2l)))).equals((new HashMap<Long,String>(Map.of(1l, "a", 2l, "d", 3l, "c")))));
    }

}
