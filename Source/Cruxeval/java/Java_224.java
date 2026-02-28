import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_224 {
    public static HashMap<String,Long> f(ArrayList<String> array, long value) {
        Collections.reverse(array);
        array.remove(array.size() - 1);
        List<HashMap<String, Long>> odd = new ArrayList<>();
        while (!array.isEmpty()) {
            HashMap<String, Long> tmp = new HashMap<>();
            tmp.put(array.remove(array.size() - 1), value);
            odd.add(tmp);
        }
        HashMap<String, Long> result = new HashMap<>();
        while (!odd.isEmpty()) {
            result.putAll(odd.remove(odd.size() - 1));
        }
        return result;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"23"))), (123l)).equals((new HashMap<String,Long>())));
    }

}
