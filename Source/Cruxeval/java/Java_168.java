import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_168 {
    public static String f(String text, String new_value, long index) {
        char[] charArray = text.toCharArray();
        charArray[(int)index] = new_value.charAt(0);
        return new String(charArray);
    }
    public static void main(String[] args) {
    assert(f(("spain"), ("b"), (4l)).equals(("spaib")));
    }

}
