import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_486 {
    public static HashMap<Long,Long> f(HashMap<Long,Long> dic) {
        HashMap<Long, Long> dic_op = new HashMap<>(dic);
        for (Map.Entry<Long, Long> entry : dic_op.entrySet()) {
            dic_op.put(entry.getKey(), entry.getValue() * entry.getValue());
        }
        return dic_op;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<Long,Long>(Map.of(1l, 1l, 2l, 2l, 3l, 3l)))).equals((new HashMap<Long,Long>(Map.of(1l, 1l, 2l, 4l, 3l, 9l)))));
    }

}
