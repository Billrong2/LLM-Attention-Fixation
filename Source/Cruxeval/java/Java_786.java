import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_786 {
    public static String f(String text, String letter) {
        if (text.contains(letter)) {
            int start = text.indexOf(letter);
            return text.substring(start + 1) + text.substring(0, start + 1);
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("19kefp7"), ("9")).equals(("kefp719")));
    }

}
