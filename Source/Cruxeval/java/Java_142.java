import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_142 {
    public static String f(String x) {
        if (x.equals(x.toLowerCase())) {
            return x;
        } else {
            return new StringBuilder(x).reverse().toString();
        }
    }
    public static void main(String[] args) {
    assert(f(("ykdfhp")).equals(("ykdfhp")));
    }

}
