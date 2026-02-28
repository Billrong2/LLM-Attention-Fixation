import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_207 {
    public static HashMap<String,Long> f(ArrayList<HashMap<String,Long>> commands) {
        HashMap<String, Long> d = new HashMap<>();
        for (HashMap<String, Long> c : commands) {
            d.putAll(c);
        }
        return d;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<HashMap<String,Long>>(Arrays.asList((HashMap<String,Long>)new HashMap<String,Long>(Map.of("brown", 2l)), (HashMap<String,Long>)new HashMap<String,Long>(Map.of("blue", 5l)), (HashMap<String,Long>)new HashMap<String,Long>(Map.of("bright", 4l)))))).equals((new HashMap<String,Long>(Map.of("brown", 2l, "blue", 5l, "bright", 4l)))));
    }

}
