import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_609 {
    public static HashMap<Long,Long> f(HashMap<Long,Long> array, long elem) {
        HashMap<Long, Long> result = new HashMap<>(array);
        while (!result.isEmpty()) {
            for (Map.Entry<Long, Long> entry : new HashMap<>(result).entrySet()) {
                if (elem == entry.getKey() || elem == entry.getValue()) {
                    result.putAll(array);
                }
                result.remove(entry.getKey());
            }
        }
        return result;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<Long,Long>(Map.of())), (1l)).equals((new HashMap<Long,Long>(Map.of()))));
    }

}
