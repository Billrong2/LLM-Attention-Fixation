import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_258 {
    public static ArrayList<Long> f(ArrayList<Long> L, long m, long start, long step) {
        L.add((int)start, m);
        for (int x = (int)start - 1; x > 0; x -= step) {
            start -= 1;
            L.add((int)start, L.remove((int)x));
        }
        return L;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)7l, (long)9l))), (3l), (3l), (2l)).equals((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)7l, (long)3l, (long)9l)))));
    }

}
