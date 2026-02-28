import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_039 {
    public static long f(ArrayList<Long> array, long elem) {
        if (array.contains(elem)) {
            return array.indexOf(elem);
        }
        return -1;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)6l, (long)2l, (long)7l, (long)1l))), (6l)) == (0l));
    }

}
