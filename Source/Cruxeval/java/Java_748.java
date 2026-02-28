import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_748 {
    public static Pair<Pair<String, Long>, Pair<String, Long>> f(HashMap<String,Long> d) {
        Iterator<Map.Entry<String, Long>> iterator = d.entrySet().iterator();
        Map.Entry<String, Long> firstEntry = iterator.next();
        Map.Entry<String, Long> secondEntry = iterator.next();
        return new Pair<>(new Pair<>(firstEntry.getKey(), firstEntry.getValue()), new Pair<>(secondEntry.getKey(), secondEntry.getValue()));
    }
    public static void main(String[] args) {
    assert(f((new HashMap<String,Long>(Map.of("a", 123l, "b", 456l, "c", 789l)))).equals((Pair.with(Pair.with("a", 123l), Pair.with("b", 456l)))));
    }

}
