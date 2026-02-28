import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_685 {
    public static long f(ArrayList<Long> array, long elem) {
        return Collections.frequency(array, elem) + elem;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)1l, (long)1l))), (-2l)) == (-2l));
    }

}
