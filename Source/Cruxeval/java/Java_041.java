import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_041 {
    public static ArrayList<Long> f(ArrayList<Long> array, ArrayList<Long> values) {
        Collections.reverse(array);
        for (long value : values) {
            array.add(array.size() / 2, value);
        }
        Collections.reverse(array);
        return array;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)58l))), (new ArrayList<Long>(Arrays.asList((long)21l, (long)92l)))).equals((new ArrayList<Long>(Arrays.asList((long)58l, (long)92l, (long)21l)))));
    }

}
