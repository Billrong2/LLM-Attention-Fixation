import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_276 {
    public static ArrayList<Long> f(ArrayList<Long> a) {
        if (a.size() >= 2 && a.get(0) > 0 && a.get(1) > 0) {
            Collections.reverse(a);
            return a;
        }
        a.add(0L);
        return a;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList()))).equals((new ArrayList<Long>(Arrays.asList((long)0l)))));
    }

}
