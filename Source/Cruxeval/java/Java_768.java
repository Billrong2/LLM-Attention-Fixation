import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_768 {
    public static String f(String s, String o) {
        if (s.startsWith(o)) {
            return s;
        }
        return o + f(s, new StringBuilder(o).deleteCharAt(o.length() - 1).reverse().toString());
    }
    public static void main(String[] args) {
    assert(f(("abba"), ("bab")).equals(("bababba")));
    }

}
