import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_407 {
    public static long f(ArrayList<Long> s) {
        while (s.size() > 1) {
            s.clear();
            s.add((long) s.size());
        }
        return s.remove(0);
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)6l, (long)1l, (long)2l, (long)3l)))) == (0l));
    }

}
