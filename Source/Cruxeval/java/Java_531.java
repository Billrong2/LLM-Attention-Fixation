import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;

class Java_531 {
    public static String f(String text, String x) {
        if (!text.startsWith(x)) {
            return f(text.substring(1), x);
        } else {
            return text;
        }
    }
    public static void main(String[] args) {
    assert(f(("Ibaskdjgblw asdl "), ("djgblw")).equals(("djgblw asdl ")));
    }

}
