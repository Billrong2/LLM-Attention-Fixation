import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_211 {
    public static long f(String s) {
        int count = 0;
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (s.lastIndexOf(c) != s.indexOf(c)) {
                count++;
            }
        }
        return count;
    }
    public static void main(String[] args) {
    assert(f(("abca dea ead")) == (10l));
    }

}
