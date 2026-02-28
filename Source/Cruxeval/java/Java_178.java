import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_178 {
    public static ArrayList<Long> f(ArrayList<Long> array, long n) {
        return new ArrayList<Long>(array.subList((int)n, array.size()));
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)0l, (long)0l, (long)1l, (long)2l, (long)2l, (long)2l, (long)2l))), (4l)).equals((new ArrayList<Long>(Arrays.asList((long)2l, (long)2l, (long)2l)))));
    }

}
