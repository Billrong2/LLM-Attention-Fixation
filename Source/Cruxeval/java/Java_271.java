import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_271 {
    public static String f(String text, String c) {
        char[] ls = text.toCharArray();
        if (text.indexOf(c) == -1) {
            throw new IllegalArgumentException("Text has no " + c);
        }
        ls[text.lastIndexOf(c)] = '\0';
        return new String(ls).replace("\0", "");
    }
    public static void main(String[] args) {
    assert(f(("uufhl"), ("l")).equals(("uufh")));
    }

}
