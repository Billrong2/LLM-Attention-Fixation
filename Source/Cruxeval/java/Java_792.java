import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_792 {
    public static HashMap<String,ArrayList<String>> f(ArrayList<String> l1, ArrayList<String> l2) {
        if (l1.size() != l2.size()) {
            return new HashMap<>();
        }
        HashMap<String, ArrayList<String>> map = new HashMap<>();
        for (String key : l1) {
            map.put(key, new ArrayList<>(l2));
        }
        return map;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"a", (String)"b"))), (new ArrayList<String>(Arrays.asList((String)"car", (String)"dog")))).equals((new HashMap<String,ArrayList<String>>(Map.of("a", new ArrayList<String>(Arrays.asList((String)"car", (String)"dog")), "b", new ArrayList<String>(Arrays.asList((String)"car", (String)"dog")))))));
    }

}
