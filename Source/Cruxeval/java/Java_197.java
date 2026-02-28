import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_197 {
    public static String f(long temp, long timeLimit) {
        long s = timeLimit / temp;
        long e = timeLimit % temp;
        return s > 1 ? String.format("%d %d", s, e) : String.format("%d oC", e);
    }
    public static void main(String[] args) {
    assert(f((1l), (1234567890l)).equals(("1234567890 0")));
    }

}
