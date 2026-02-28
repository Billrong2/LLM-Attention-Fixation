import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_691 {
    public static String f(String text, String suffix) {
        if (suffix != null && suffix.length() > 0 && text.contains(String.valueOf(suffix.charAt(suffix.length() - 1)))) {
            return f(text.replaceAll(suffix.charAt(suffix.length() - 1) + "$", ""), suffix.substring(0, suffix.length() - 1));
        } else {
            return text;
        }
    }
    public static void main(String[] args) {
    assert(f(("rpyttc"), ("cyt")).equals(("rpytt")));
    }

}
