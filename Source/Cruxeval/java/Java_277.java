import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_277 {
    public static ArrayList<Long> f(ArrayList<Long> lst, long mode) {
        ArrayList<Long> result = new ArrayList<>(lst);
        if (mode != 0) {
            Collections.reverse(result);
        }
        return result;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l, (long)4l))), (1l)).equals((new ArrayList<Long>(Arrays.asList((long)4l, (long)3l, (long)2l, (long)1l)))));
    }

}
