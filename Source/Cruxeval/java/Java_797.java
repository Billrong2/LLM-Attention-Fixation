import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_797 {
    public static ArrayList<Pair<String, Long>> f(HashMap<String,Long> dct) {
        ArrayList<Pair<String, Long>> lst = new ArrayList<>();
        for (String key : new TreeSet<>(dct.keySet())) {
            lst.add(new Pair<>(key, dct.get(key)));
        }
        return lst;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<String,Long>(Map.of("a", 1l, "b", 2l, "c", 3l)))).equals((new ArrayList<Pair<String, Long>>(Arrays.asList((Pair<String, Long>)Pair.with("a", 1l), (Pair<String, Long>)Pair.with("b", 2l), (Pair<String, Long>)Pair.with("c", 3l))))));
    }

}
