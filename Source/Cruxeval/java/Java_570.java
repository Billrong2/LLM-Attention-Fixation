import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_570 {
    public static ArrayList<Long> f(ArrayList<Long> array, long index, long value) {
        array.add(0, index + 1);
        if (value >= 1) {
            array.add((int)index, value);
        }
        return array;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)2l))), (0l), (2l)).equals((new ArrayList<Long>(Arrays.asList((long)2l, (long)1l, (long)2l)))));
    }

}
