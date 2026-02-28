import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_627 {
    public static ArrayList<Long> f(ArrayList<Pair<String, Long>> parts) {
        Map<String, Long> map = new HashMap<>();
        for (Pair<String, Long> part : parts) {
            map.put(part.getValue0(), part.getValue1());
        }
        
        return new ArrayList<>(new HashSet<>(map.values()));
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Pair<String, Long>>(Arrays.asList((Pair<String, Long>)Pair.with("u", 1l), (Pair<String, Long>)Pair.with("s", 7l), (Pair<String, Long>)Pair.with("u", -5l))))).equals((new ArrayList<Long>(Arrays.asList((long)-5l, (long)7l)))));
    }

}
