import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_582 {
    public static ArrayList<Long> f(long k, long j) {
        ArrayList<Long> arr = new ArrayList<>();
        for (long i = 0; i < k; i++) {
            arr.add(j);
        }
        return arr;
    }
    public static void main(String[] args) {
    assert(f((7l), (5l)).equals((new ArrayList<Long>(Arrays.asList((long)5l, (long)5l, (long)5l, (long)5l, (long)5l, (long)5l, (long)5l)))));
    }

}
