import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_791 {
    public static String f(long integer, long n) {
        long i = 1;
        String text = Long.toString(integer);
        while (i + text.length() < n) {
            i += text.length();
        }
        return String.format("%1$" + (i + text.length()) + "s", text).replace(' ', '0');
    }
    public static void main(String[] args) {
    assert(f((8999l), (2l)).equals(("08999")));
    }

}
