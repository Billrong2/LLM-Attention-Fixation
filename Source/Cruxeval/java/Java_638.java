import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_638 {
    public static String f(String s, String suffix) {
        if (suffix.isEmpty()) {
            return s;
        }
        while (s.endsWith(suffix)) {
            s = s.substring(0, s.length() - suffix.length());
        }
        return s;
    }
    public static void main(String[] args) {
    assert(f(("ababa"), ("ab")).equals(("ababa")));
    }

}
