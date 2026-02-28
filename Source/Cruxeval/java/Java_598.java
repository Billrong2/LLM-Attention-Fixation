import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_598 {
    public static String f(String text, long n) {
        int length = text.length();
        return text.substring(length * (int) (n % 4), length);
    }
    public static void main(String[] args) {
    assert(f(("abc"), (1l)).equals(("")));
    }

}
