import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_221 {
    public static String f(String text, String delim) {
        if (text.contains(delim)) {
            int index = text.indexOf(delim);
            return text.substring(index + delim.length()) + delim + text.substring(0, index);
        } else {
            return text;
        }
    }
    public static void main(String[] args) {
    assert(f(("bpxa24fc5."), (".")).equals((".bpxa24fc5")));
    }

}
