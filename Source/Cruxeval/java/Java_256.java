import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_256 {
    public static long f(String text, String sub) {
        long a = 0;
        long b = text.length() - 1;

        while (a <= b) {
            long c = (a + b) / 2;
            if (text.lastIndexOf(sub) >= c) {
                a = c + 1;
            } else {
                b = c - 1;
            }
        }

        return a;
    }
    public static void main(String[] args) {
    assert(f(("dorfunctions"), ("2")) == (0l));
    }

}
