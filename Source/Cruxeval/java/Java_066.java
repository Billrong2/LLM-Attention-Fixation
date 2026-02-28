import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;

class Java_066 {
    public static String f(String text, String prefix) {
        int prefix_length = prefix.length();
        if (text.startsWith(prefix)) {
            int start = (prefix_length - 1) / 2;
            int end = prefix_length % 2 == 0 ? (prefix_length / 2 - 1) : (prefix_length / 2);
            return new StringBuilder(text.substring(start, end)).reverse().toString();
        } else {
            return text;
        }
    }
    public static void main(String[] args) {
    assert(f(("happy"), ("ha")).equals(("")));
    }

}
