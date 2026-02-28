import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_227 {
    public static String f(String text) {
        text = text.toLowerCase();
        char head = text.charAt(0);
        String tail = text.substring(1);
        return Character.toUpperCase(head) + tail;
    }
    public static void main(String[] args) {
    assert(f(("Manolo")).equals(("Manolo")));
    }

}
