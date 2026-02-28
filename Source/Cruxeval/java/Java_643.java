import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_643 {
    public static String f(String text, String suffix) {
        if (text.endsWith(suffix)) {
            text = text.substring(0, text.length() - 1) + Character.toString(text.charAt(text.length() - 1)).toUpperCase();
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("damdrodm"), ("m")).equals(("damdrodM")));
    }

}
