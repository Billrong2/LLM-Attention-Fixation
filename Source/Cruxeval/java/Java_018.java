import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_018 {
    public static ArrayList<Long> f(ArrayList<Long> array, long elem) {
        int k = 0;
        List<Long> l = new ArrayList<>(array);
        for (Long i : l) {
            if (i > elem) {
                array.add(k, elem);
                break;
            }
            k++;
        }
        return array;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)5l, (long)4l, (long)3l, (long)2l, (long)1l, (long)0l))), (3l)).equals((new ArrayList<Long>(Arrays.asList((long)3l, (long)5l, (long)4l, (long)3l, (long)2l, (long)1l, (long)0l)))));
    }

}
