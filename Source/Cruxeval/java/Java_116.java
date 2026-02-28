import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_116 {
    public static HashMap<Long,Long> f(HashMap<Long,Long> d, long count) {
        for(int i = 0; i < count; i++) {
            if(d.isEmpty()) {
                break;
            }
            d.remove(d.entrySet().iterator().next().getKey());
        }
        return d;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<Long,Long>(Map.of())), (200l)).equals((new HashMap<Long,Long>(Map.of()))));
    }

}
