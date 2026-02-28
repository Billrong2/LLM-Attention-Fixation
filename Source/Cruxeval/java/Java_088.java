import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_088 {
    public static String f(String s1, String s2) {
        if (s2.endsWith(s1)) {
            s2 = s2.substring(0, s2.length() - s1.length());
        }
        return s2;
    }
    public static void main(String[] args) {
    assert(f(("he"), ("hello")).equals(("hello")));
    }

}
