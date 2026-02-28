import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_442 {
    public static ArrayList<Long> f(ArrayList<Long> lst) {
        ArrayList<Long> res = new ArrayList<>();
        for (long num : lst) {
            if (num % 2 == 0) {
                res.add(num);
            }
        }
        return new ArrayList<>(lst);
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l, (long)4l)))).equals((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l, (long)4l)))));
    }

}
