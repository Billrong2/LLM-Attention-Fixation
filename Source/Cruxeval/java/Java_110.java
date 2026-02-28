import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_110 {
    public static long f(String text) {
        String[] a = {""};
        String b = "";
        for (int i = 0; i < text.length(); i++) {
            if (!Character.isWhitespace(text.charAt(i))) {
                a = Arrays.copyOf(a, a.length + 1);
                a[a.length - 1] = b;
                b = "";
            } else {
                b += text.charAt(i);
            }
        }
        return a.length;
    }
    public static void main(String[] args) {
    assert(f(("       ")) == (1l));
    }

}
