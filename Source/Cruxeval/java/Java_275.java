import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_275 {
    public static HashMap<String,Long> f(HashMap<Long,String> dic) {
        HashMap<String, Long> dic2 = new HashMap<>();
        for (Map.Entry<Long, String> entry : dic.entrySet()) {
            dic2.put(entry.getValue(), entry.getKey());
        }
        return dic2;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<Long,String>(Map.of(-1l, "a", 0l, "b", 1l, "c")))).equals((new HashMap<String,Long>(Map.of("a", -1l, "b", 0l, "c", 1l)))));
    }

}
