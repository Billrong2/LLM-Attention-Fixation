import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_248 {
    public static ArrayList<Long> f(ArrayList<Long> a, ArrayList<Long> b) {
        Collections.sort(a);
        b.sort(Comparator.reverseOrder());
        a.addAll(b);
        return a;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)666l))), (new ArrayList<Long>(Arrays.asList()))).equals((new ArrayList<Long>(Arrays.asList((long)666l)))));
    }

}
