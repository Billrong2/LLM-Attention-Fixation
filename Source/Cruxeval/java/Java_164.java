import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_164 {
    public static ArrayList<Long> f(ArrayList<Long> lst) {
        Collections.sort(lst);
        return new ArrayList<>(lst.subList(0, 3));
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)5l, (long)8l, (long)1l, (long)3l, (long)0l)))).equals((new ArrayList<Long>(Arrays.asList((long)0l, (long)1l, (long)3l)))));
    }

}
