import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_475 {
    public static long f(ArrayList<Long> array, long index) {
        if (index < 0) {
            index = array.size() + index;
        }
        return array.get((int)index);
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l))), (0l)) == (1l));
    }

}
