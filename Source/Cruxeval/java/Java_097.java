import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_097 {
    public static boolean f(ArrayList<Long> lst) {
        lst.clear();
        for (long i : lst) {
            if (i == 3) {
                return false;
            }
        }
        return true;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)2l, (long)0l)))) == (true));
    }

}
