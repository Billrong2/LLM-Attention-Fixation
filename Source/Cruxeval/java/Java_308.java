import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_308 {
    public static HashMap<String,Long> f(ArrayList<String> strings) {
        HashMap<String, Long> occurrences = new HashMap<>();
        for (String string : strings) {
            if (!occurrences.containsKey(string)) {
                occurrences.put(string, strings.stream().filter(s -> s.equals(string)).count());
            }
        }
        return occurrences;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"La", (String)"Q", (String)"9", (String)"La", (String)"La")))).equals((new HashMap<String,Long>(Map.of("La", 3l, "Q", 1l, "9", 1l)))));
    }

}
