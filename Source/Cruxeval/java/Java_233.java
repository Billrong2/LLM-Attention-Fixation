import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_233 {
    public static ArrayList<Long> f(ArrayList<Long> xs) {
        for (int idx = -xs.size(); idx < 0; idx++) {
            xs.add(0, xs.remove(xs.size()-1));
        }
        return xs;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l)))).equals((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l)))));
    }

}
