import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_304 {
    public static HashMap<Long,Long> f(HashMap<Long,Long> d) {
        long key1 = d.entrySet().stream()
                .sorted(Map.Entry.comparingByKey(Comparator.reverseOrder()))
                .findFirst().get().getKey();
        long val1 = d.remove(key1);
        
        long key2 = d.entrySet().stream()
                .sorted(Map.Entry.comparingByKey(Comparator.reverseOrder()))
                .findFirst().get().getKey();
        long val2 = d.remove(key2);
        
        HashMap<Long, Long> result = new HashMap<>();
        result.put(key1, val1);
        result.put(key2, val2);
        return result;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<Long,Long>(Map.of(2l, 3l, 17l, 3l, 16l, 6l, 18l, 6l, 87l, 7l)))).equals((new HashMap<Long,Long>(Map.of(87l, 7l, 18l, 6l)))));
    }

}
