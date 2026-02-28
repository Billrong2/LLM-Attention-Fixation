import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_421 {
    public static String f(String s, long n) {
        if (s.length() < n) {
            return s;
        } else {
            return s.substring((int)n);
        }
    }
    public static void main(String[] args) {
    assert(f(("try."), (5l)).equals(("try.")));
    }

}
