import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_294 {
    public static String f(String n, String m, String text) {
        if (text.trim().isEmpty()) {
            return text;
        }
        String head = text.substring(0, 1);
        String mid = text.substring(1, text.length() - 1);
        String tail = text.substring(text.length() - 1);

        String joined = head.replace(n, m) + mid.replace(n, m) + tail.replace(n, m);
        return joined;
    }
    public static void main(String[] args) {
    assert(f(("x"), ("$"), ("2xz&5H3*1a@#a*1hris")).equals(("2$z&5H3*1a@#a*1hris")));
    }

}
