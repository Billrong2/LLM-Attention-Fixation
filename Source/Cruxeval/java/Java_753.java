import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_753 {
    public static HashMap<Long,Long> f(HashMap<Long,Long> bag) {
        HashMap<Long, Long> tbl = new HashMap<>();
        List<Long> values = new ArrayList<>(bag.values());
        for (long v = 0; v < 100; v++) {
            if (values.contains(v)) {
                tbl.put(v, (long)Collections.frequency(values, (Long)v));
            }
        }
        return tbl;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<Long,Long>(Map.of(0l, 0l, 1l, 0l, 2l, 0l, 3l, 0l, 4l, 0l)))).equals((new HashMap<Long,Long>(Map.of(0l, 5l)))));
    }

}
