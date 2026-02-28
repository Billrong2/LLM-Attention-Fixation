import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_101 {
    public static ArrayList<Long> f(ArrayList<Long> array, long i_num, long elem) {
        if (i_num >= array.size()) {
            array.add(elem);
        } else {
            array.add((int)i_num, elem);
        }
        return array;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)-4l, (long)1l, (long)0l))), (1l), (4l)).equals((new ArrayList<Long>(Arrays.asList((long)-4l, (long)4l, (long)1l, (long)0l)))));
    }

}
