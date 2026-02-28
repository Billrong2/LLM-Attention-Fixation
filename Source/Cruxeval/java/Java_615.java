import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_615 {
    public static long f(ArrayList<Long> in_list, long num) {
        in_list.add(num);
        return in_list.indexOf(Collections.max(in_list.subList(0, in_list.size() - 1)));
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)-1l, (long)12l, (long)-6l, (long)-2l))), (-1l)) == (1l));
    }

}
