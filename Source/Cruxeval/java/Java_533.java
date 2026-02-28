import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_533 {
    public static long f(String query, HashMap<String,Long> base) {
        long net_sum = 0;
        for (Map.Entry<String, Long> entry : base.entrySet()) {
            String key = entry.getKey();
            long val = entry.getValue();
            if (key.charAt(0) == query.charAt(0) && key.length() == 3) {
                net_sum -= val;
            } else if (key.charAt(2) == query.charAt(0) && key.length() == 3) {
                net_sum += val;
            }
        }
        return net_sum;
    }
    public static void main(String[] args) {
    assert(f(("a"), (new HashMap<String,Long>())) == (0l));
    }

}
