import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_021 {
    public static ArrayList<Long> f(ArrayList<Long> array) {
        long n = array.remove(array.size() - 1);
        array.add(n);
        array.add(n);
        return array;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)1l, (long)2l, (long)2l)))).equals((new ArrayList<Long>(Arrays.asList((long)1l, (long)1l, (long)2l, (long)2l, (long)2l)))));
    }

}
