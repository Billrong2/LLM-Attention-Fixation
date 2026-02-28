import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;

class Java_463 {
    public static HashMap<Long,Long> f(HashMap<Long,Long> dict) {
        HashMap<Long,Long> result = new HashMap<>(dict);
        for (Map.Entry<Long,Long> entry : dict.entrySet()) {
            if (result.containsKey(entry.getValue())) {
                result.remove(entry.getKey());
            }
        }
        return result;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<Long,Long>(Map.of(-1l, -1l, 5l, 5l, 3l, 6l, -4l, -4l)))).equals((new HashMap<Long,Long>(Map.of(3l, 6l)))));
    }

}
