import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_540 {
    public static ArrayList<Long> f(ArrayList<Long> a) {
        ArrayList<Long> b = new ArrayList<>(a);
        for (int k = 0; k < a.size() - 1; k += 2) {
            b.add(k + 1, b.get(k).longValue());
        }
        b.add(b.get(0));
        return b;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)5l, (long)5l, (long)5l, (long)6l, (long)4l, (long)9l)))).equals((new ArrayList<Long>(Arrays.asList((long)5l, (long)5l, (long)5l, (long)5l, (long)5l, (long)5l, (long)6l, (long)4l, (long)9l, (long)5l)))));
    }

}
