import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_290 {
    public static String f(String text, String prefix) {
        if (text.startsWith(prefix)) {
            return text.substring(prefix.length());
        }
        if (text.contains(prefix)) {
            return text.replace(prefix, "").trim();
        }
        return text.toUpperCase();
    }
    public static void main(String[] args) {
    assert(f(("abixaaaily"), ("al")).equals(("ABIXAAAILY")));
    }

}
