import java.lang.reflect.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import org.javatuples.Pair;

class Java_790 {
    public static Pair<Boolean, Boolean> f(HashMap<String,String> d) {
        HashMap<String, HashMap<String,String>> r = new HashMap<>();
        r.put("c", new HashMap<>(d));
        r.put("d", new HashMap<>(d));
        return new Pair<>(r.get("c") == r.get("d"), r.get("c").equals(r.get("d")));
    }
    public static void main(String[] args) {
    assert(f((new HashMap<String,String>(Map.of("i", "1", "love", "parakeets")))).equals((Pair.with(false, true))));
    }

}
