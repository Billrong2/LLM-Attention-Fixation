import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_554 {
    public static ArrayList<Long> f(ArrayList<Long> arr) {
        Collections.reverse(arr);
        return arr;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)2l, (long)0l, (long)1l, (long)9999l, (long)3l, (long)-5l)))).equals((new ArrayList<Long>(Arrays.asList((long)-5l, (long)3l, (long)9999l, (long)1l, (long)0l, (long)2l)))));
    }

}
