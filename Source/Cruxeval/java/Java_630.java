import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_630 {
    public static HashMap<Long,Long> f(HashMap<Long,Long> original, HashMap<Long,Long> string) {
        HashMap<Long,Long> temp = new HashMap<>(original);
        for (Map.Entry<Long, Long> entry : string.entrySet()) {
            temp.put(entry.getValue(), entry.getKey());
        }
        return temp;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<Long,Long>(Map.of(1l, -9l, 0l, -7l))), (new HashMap<Long,Long>(Map.of(1l, 2l, 0l, 3l)))).equals((new HashMap<Long,Long>(Map.of(1l, -9l, 0l, -7l, 2l, 1l, 3l, 0l)))));
    }

}
