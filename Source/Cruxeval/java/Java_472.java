import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_472 {
    public static ArrayList<Long> f(String text) {
        Map<Character, Integer> d = new HashMap<>();
        for (char c : text.replace("-", "").toLowerCase().toCharArray()) {
            d.put(c, d.getOrDefault(c, 0) + 1);
        }
        
        List<Map.Entry<Character, Integer>> list = new ArrayList<>(d.entrySet());
        list.sort((a, b) -> a.getValue().compareTo(b.getValue()));
        
        ArrayList<Long> result = new ArrayList<>();
        for (Map.Entry<Character, Integer> entry : list) {
            result.add(Long.valueOf(entry.getValue()));
        }
        
        return result;
    }
    public static void main(String[] args) {
    assert(f(("x--y-z-5-C")).equals((new ArrayList<Long>(Arrays.asList((long)1l, (long)1l, (long)1l, (long)1l, (long)1l)))));
    }

}
