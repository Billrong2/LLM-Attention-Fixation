import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_249 {
    public static HashMap<String,Long> f(String s) {
        HashMap<String, Long> count = new HashMap<>();
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (Character.isLowerCase(c)) {
                String key = String.valueOf(c).toLowerCase();
                count.put(key, s.chars().mapToObj(ch -> (char)ch)
                        .filter(ch -> Character.toLowerCase(ch) == c)
                        .count() + count.getOrDefault(key, 0L));
            } else {
                String key = String.valueOf(Character.toLowerCase(c));
                count.put(key, s.chars().mapToObj(ch -> (char)ch)
                        .filter(ch -> Character.toLowerCase(ch) == Character.toLowerCase(c))
                        .count() + count.getOrDefault(key, 0L));
            }
        }
        return count;
    }
    public static void main(String[] args) {
    assert(f(("FSA")).equals((new HashMap<String,Long>(Map.of("f", 1l, "s", 1l, "a", 1l)))));
    }

}
