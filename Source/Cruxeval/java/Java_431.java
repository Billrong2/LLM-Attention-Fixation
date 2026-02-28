import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_431 {
    public static ArrayList<Long> f(long n, long m) {
        ArrayList<Long> arr = new ArrayList<>();
        for (long i = 1; i <= n; i++) {
            arr.add(i);
        }
        for (long i = 0; i < m; i++) {
            arr.clear();
        }
        return arr;
    }
    public static void main(String[] args) {
    assert(f((1l), (3l)).equals((new ArrayList<Long>(Arrays.asList()))));
    }

}
