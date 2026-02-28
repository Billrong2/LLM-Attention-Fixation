import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_063 {
    public static String f(String text, String prefix) {
        while (text.startsWith(prefix)) {
            text = text.substring(prefix.length()).isEmpty() ? text : text.substring(prefix.length());
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("ndbtdabdahesyehu"), ("n")).equals(("dbtdabdahesyehu")));
    }

}
