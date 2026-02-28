import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_689 {
    public static ArrayList<Long> f(ArrayList<Long> arr) {
        int count = arr.size();
        ArrayList<Long> sub = new ArrayList<>(arr);
        for (int i = 0; i < count; i += 2) {
            sub.set(i, sub.get(i) * 5);
        }
        return sub;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)-3l, (long)-6l, (long)2l, (long)7l)))).equals((new ArrayList<Long>(Arrays.asList((long)-15l, (long)-6l, (long)10l, (long)7l)))));
    }

}
