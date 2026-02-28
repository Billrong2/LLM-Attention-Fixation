import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_019 {
    public static String f(String x, String y) {
        String tmp = new StringBuilder(y).reverse().chars()
            .mapToObj(c -> (char)(c == '9' ? '0' : '9'))
            .collect(StringBuilder::new, StringBuilder::append, StringBuilder::append)
            .toString();
        if (x.matches("\\d+") && tmp.matches("\\d+")) {
            return x + tmp;
        } else {
            return x;
        }
    }
    public static void main(String[] args) {
    assert(f((""), ("sdasdnakjsda80")).equals(("")));
    }

}
