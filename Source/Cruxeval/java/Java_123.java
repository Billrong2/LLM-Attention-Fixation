import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_123 {
    public static ArrayList<Long> f(ArrayList<Long> array, long elem) {
        for (int idx = 0; idx < array.size(); idx++) {
            if (array.get(idx) > elem && array.get(idx - 1) < elem) {
                array.add(idx, elem);
            }
        }
        return array;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l, (long)5l, (long)8l))), (6l)).equals((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l, (long)5l, (long)6l, (long)8l)))));
    }

}
