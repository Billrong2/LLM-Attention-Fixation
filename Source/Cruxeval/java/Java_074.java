import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_074 {
    public static ArrayList<Long> f(ArrayList<Long> lst, long i, long n) {
        lst.add((int)i, (long)n);
        return lst;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)44l, (long)34l, (long)23l, (long)82l, (long)24l, (long)11l, (long)63l, (long)99l))), (4l), (15l)).equals((new ArrayList<Long>(Arrays.asList((long)44l, (long)34l, (long)23l, (long)82l, (long)15l, (long)24l, (long)11l, (long)63l, (long)99l)))));
    }

}
