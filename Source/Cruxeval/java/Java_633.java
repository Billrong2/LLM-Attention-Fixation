import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_633 {
    public static long f(ArrayList<Long> array, long elem) {
        Collections.reverse(array);
        try {
            int found = array.indexOf(elem);
            return found;
        } finally {
            Collections.reverse(array);
        }
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)5l, (long)-3l, (long)3l, (long)2l))), (2l)) == (0l));
    }

}
