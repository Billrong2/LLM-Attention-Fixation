import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_309 {
    public static String f(String text, String suffix) {
        text += suffix;
        while (text.substring(text.length() - suffix.length()).equals(suffix)) {
            text = text.substring(0, text.length() - 1);
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("faqo osax f"), ("f")).equals(("faqo osax ")));
    }

}
