import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_478 {
    public static HashMap<String,Long> f(String sb) {
        HashMap<String, Long> d = new HashMap<>();
        for (int i = 0; i < sb.length(); i++) {
            String s = String.valueOf(sb.charAt(i));
            d.put(s, d.getOrDefault(s, 0L) + 1);
        }
        return d;
    }
    public static void main(String[] args) {
    assert(f(("meow meow")).equals((new HashMap<String,Long>(Map.of("m", 2l, "e", 2l, "o", 2l, "w", 2l, " ", 1l)))));
    }

}
