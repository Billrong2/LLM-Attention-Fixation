import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_487 {
    public static ArrayList<Long> f(HashMap<Long,String> dict) {
        ArrayList<Long> evenKeys = new ArrayList<>();
        for (Long key : dict.keySet()) {
            if (key % 2 == 0) {
                evenKeys.add(key);
            }
        }
        return evenKeys;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<Long,String>(Map.of(4l, "a")))).equals((new ArrayList<Long>(Arrays.asList((long)4l)))));
    }

}
