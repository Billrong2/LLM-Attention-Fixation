import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_408 {
    public static ArrayList<Long> f(ArrayList<Long> m) {
        Collections.reverse(m);
        return m;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)-4l, (long)6l, (long)0l, (long)4l, (long)-7l, (long)2l, (long)-1l)))).equals((new ArrayList<Long>(Arrays.asList((long)-1l, (long)2l, (long)-7l, (long)4l, (long)0l, (long)6l, (long)-4l)))));
    }

}
