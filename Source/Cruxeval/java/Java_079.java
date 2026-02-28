import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_079 {
    public static String f(ArrayList<Long> arr) {
        arr.clear();
        arr.add(1L);
        arr.add(2L);
        arr.add(3L);
        arr.add(4L);
        return String.join(",", arr.stream().map(Object::toString).collect(Collectors.toList()));
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)0l, (long)1l, (long)2l, (long)3l, (long)4l)))).equals(("1,2,3,4")));
    }

}
