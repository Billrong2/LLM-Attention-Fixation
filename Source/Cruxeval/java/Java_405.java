import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_405 {
    public static ArrayList<Long> f(ArrayList<Long> xs) {
        long new_x = xs.get(0) - 1;
        xs.remove(0);
        while (new_x <= xs.get(0)) {
            xs.remove(0);
            new_x--;
        }
        xs.add(0, new_x);
        return xs;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)6l, (long)3l, (long)4l, (long)1l, (long)2l, (long)3l, (long)5l)))).equals((new ArrayList<Long>(Arrays.asList((long)5l, (long)3l, (long)4l, (long)1l, (long)2l, (long)3l, (long)5l)))));
    }

}
