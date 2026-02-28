import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_075 {
    public static long f(ArrayList<Long> array, long elem) {
        int ind = array.indexOf(elem);
        return ind * 2 + array.get(array.size() - ind - 1) * 3;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)-1l, (long)2l, (long)1l, (long)-8l, (long)2l))), (2l)) == (-22l));
    }

}
