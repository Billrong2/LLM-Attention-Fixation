import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_045 {
    public static long f(String text, String letter) {
        Map<Character, Integer> counts = new HashMap<>();
        for (char c : text.toCharArray()) {
            if (!counts.containsKey(c)) {
                counts.put(c, 1);
            } else {
                counts.put(c, counts.get(c) + 1);
            }
        }
        return counts.getOrDefault(letter.charAt(0), 0);
    }
    public static void main(String[] args) {
    assert(f(("za1fd1as8f7afasdfam97adfa"), ("7")) == (2l));
    }

}
