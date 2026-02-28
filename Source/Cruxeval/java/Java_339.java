import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_339 {
    public static long f(ArrayList<Long> array, long elem) {
        int d = 0;
        String elemStr = String.valueOf(elem);
        for (Long i : array) {
            if (String.valueOf(i).equals(elemStr)) {
                d++;
            }
        }
        return d;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)-1l, (long)2l, (long)1l, (long)-8l, (long)-8l, (long)2l))), (2l)) == (2l));
    }

}
