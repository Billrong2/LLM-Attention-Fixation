import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_513 {
    public static ArrayList<Long> f(ArrayList<Long> array) {
        while (array.contains(-1)) {
            array.remove(2);
        }
        while (array.contains(0l)) {
            array.remove(array.size() - 1);
        }
        while (array.contains(1l)) {
            array.remove(0);
        }
        return array;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)0l, (long)2l)))).equals((new ArrayList<Long>(Arrays.asList()))));
    }

}
