import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_548 {
    public static String f(String text, String suffix) {
        if (suffix != null && text != null && text.endsWith(suffix)) {
            return text.substring(0, text.length() - suffix.length());
        } else {
            return text;
        }
    }
    public static void main(String[] args) {
    assert(f(("spider"), ("ed")).equals(("spider")));
    }

}
