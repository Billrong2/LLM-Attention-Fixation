import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_608 {
    public static HashMap<Long,Long> f(HashMap<Long,Long> aDict) {
        HashMap<Long, Long> newDict = new HashMap<>();
        for (Map.Entry<Long, Long> entry : aDict.entrySet()) {
            newDict.put(entry.getValue(), entry.getKey());
        }
        return newDict;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<Long,Long>(Map.of(1l, 1l, 2l, 2l, 3l, 3l)))).equals((new HashMap<Long,Long>(Map.of(1l, 1l, 2l, 2l, 3l, 3l)))));
    }

}
