import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_704 {
    public static String f(String s, long n, String c) {
        int width = c.length() * (int) n;
        while (s.length() < width) {
            s = c + s;
        }
        return s;
    }
    public static void main(String[] args) {
    assert(f(("."), (0l), ("99")).equals((".")));
    }

}
