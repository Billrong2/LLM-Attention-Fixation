import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_187 {
    public static long f(HashMap<Long,Long> d, long index) {
        long length = d.size();
        long idx = index % length;
        long v = d.entrySet().iterator().next().getValue();
        for (int i = 0; i < idx; i++) {
            d.remove(d.keySet().iterator().next());
        }
        return v;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<Long,Long>(Map.of(27l, 39l))), (1l)) == (39l));
    }

}
