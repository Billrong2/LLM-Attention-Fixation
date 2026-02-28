import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_158 {
    public static ArrayList<Long> f(ArrayList<Long> arr) {
        ArrayList<Long> n = new ArrayList<>();
        for (Long item : arr) {
            if (item % 2 == 0) {
                n.add(item);
            }
        }
        ArrayList<Long> m = new ArrayList<>();
        m.addAll(n);
        m.addAll(arr);
        m.retainAll(n);
        return m;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)3l, (long)6l, (long)4l, (long)-2l, (long)5l)))).equals((new ArrayList<Long>(Arrays.asList((long)6l, (long)4l, (long)-2l, (long)6l, (long)4l, (long)-2l)))));
    }

}
