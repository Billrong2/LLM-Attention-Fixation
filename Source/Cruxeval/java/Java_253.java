import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_253 {
    public static String f(String text, String pref) {
        int length = pref.length();
        if (pref.equals(text.substring(0, length))) {
            return text.substring(length);
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("kumwwfv"), ("k")).equals(("umwwfv")));
    }

}
