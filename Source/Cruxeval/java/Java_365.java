import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_365 {
    public static String f(String n, String s) {
        if (s.startsWith(n)) {
            String[] parts = s.split(n, 2);
            return parts[0] + n + s.substring(n.length());
        }
        return s;
    }
    public static void main(String[] args) {
    assert(f(("xqc"), ("mRcwVqXsRDRb")).equals(("mRcwVqXsRDRb")));
    }

}
