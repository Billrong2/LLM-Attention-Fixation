import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_778 {
    public static String f(String prefix, String text) {
        if (text.startsWith(prefix)) {
            return text;
        } else {
            return prefix + text;
        }
    }
    public static void main(String[] args) {
    assert(f(("mjs"), ("mjqwmjsqjwisojqwiso")).equals(("mjsmjqwmjsqjwisojqwiso")));
    }

}
