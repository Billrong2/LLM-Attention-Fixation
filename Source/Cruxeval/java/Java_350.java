import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_350 {
    public static ArrayList<Long> f(HashMap<String,Long> d) {
        int size = d.size();
        ArrayList<Long> v = new ArrayList<>(Collections.nCopies(size, 0L));
        if (size == 0) {
            return v;
        }
        int index = 0;
        for (long e : d.values()) {
            v.set(index, e);
            index++;
        }
        return v;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<String,Long>(Map.of("a", 1l, "b", 2l, "c", 3l)))).equals((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l)))));
    }

}
