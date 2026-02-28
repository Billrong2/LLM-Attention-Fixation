import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_793 {
    public static long f(ArrayList<Long> lst, long start, long end) {
        long count = 0;
        for (long i = start; i < end; i++) {
            for (long j = i; j < end; j++) {
                if (!lst.get((int)i).equals(lst.get((int)j))) {
                    count += 1;
                }
            }
        }
        return count;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)4l, (long)3l, (long)2l, (long)1l))), (0l), (3l)) == (3l));
    }

}
