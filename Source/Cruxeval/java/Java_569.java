import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_569 {
    public static long f(String txt) {
        Map<Character, Integer> coincidences = new HashMap<>();
        for (int i = 0; i < txt.length(); i++) {
            char c = txt.charAt(i);
            coincidences.put(c, coincidences.getOrDefault(c, 0) + 1);
        }
        
        int sum = 0;
        for (int value : coincidences.values()) {
            sum += value;
        }
        
        return sum;
    }
    public static void main(String[] args) {
    assert(f(("11 1 1")) == (6l));
    }

}
