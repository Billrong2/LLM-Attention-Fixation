import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_283 {
    public static String f(HashMap<String,Long> dictionary, String key) {
        dictionary.remove(key);
        if (Collections.min(dictionary.keySet()).equals(key)) {
            key = new ArrayList<>(dictionary.keySet()).get(0);
        }
        return key;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<String,Long>(Map.of("Iron Man", 4l, "Captain America", 3l, "Black Panther", 0l, "Thor", 1l, "Ant-Man", 6l))), ("Iron Man")).equals(("Iron Man")));
    }

}
