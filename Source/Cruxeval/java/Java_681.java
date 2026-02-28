import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_681 {
    public static ArrayList<Long> f(ArrayList<Long> array, long ind, long elem) {
        int index = (int) (ind < 0 ? -5 : ind > array.size() ? array.size() : ind + 1);
        array.add(index, elem);
        return array;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)5l, (long)8l, (long)2l, (long)0l, (long)3l))), (2l), (7l)).equals((new ArrayList<Long>(Arrays.asList((long)1l, (long)5l, (long)8l, (long)7l, (long)2l, (long)0l, (long)3l)))));
    }

}
