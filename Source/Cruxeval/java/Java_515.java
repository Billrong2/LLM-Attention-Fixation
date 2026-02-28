import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_515 {
    public static ArrayList<Long> f(ArrayList<Long> array) {
        ArrayList<Long> result = new ArrayList<>(array);
        Collections.reverse(result);
        result.replaceAll(item -> item * 2);
        return result;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l, (long)4l, (long)5l)))).equals((new ArrayList<Long>(Arrays.asList((long)10l, (long)8l, (long)6l, (long)4l, (long)2l)))));
    }

}
