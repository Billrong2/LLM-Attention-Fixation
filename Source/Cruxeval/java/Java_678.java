import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_678 {
    public static HashMap<String,Long> f(String text) {
        HashMap<String, Long> freq = new HashMap<>();
        for (char c : text.toLowerCase().toCharArray()) {
            String key = String.valueOf(c);
            if (freq.containsKey(key)) {
                freq.put(key, freq.get(key) + 1);
            } else {
                freq.put(key, 1L);
            }
        }
        return freq;
    }
    public static void main(String[] args) {
    assert(f(("HI")).equals((new HashMap<String,Long>(Map.of("h", 1l, "i", 1l)))));
    }

}
