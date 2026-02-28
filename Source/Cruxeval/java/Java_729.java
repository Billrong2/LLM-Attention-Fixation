import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_729 {
    public static ArrayList<Long> f(String s1, String s2) {
        ArrayList<Long> res = new ArrayList<>();
        long i = s1.lastIndexOf(s2);
        while (i != -1) {
            res.add(i + s2.length() - 1);
            i = s1.lastIndexOf(s2, (int)(i - 1));
        }
        return res;
    }
    public static void main(String[] args) {
    assert(f(("abcdefghabc"), ("abc")).equals((new ArrayList<Long>(Arrays.asList((long)10l, (long)2l)))));
    }

}
