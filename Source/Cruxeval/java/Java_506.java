import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_506 {
    public static String f(long n) {
        String p = "";
        if (n % 2 == 1) {
            p += "sn";
        } else {
            return String.valueOf(n * n);
        }
        for (int x = 1; x <= n; x++) {
            if (x % 2 == 0) {
                p += "to";
            } else {
                p += "ts";
            }
        }
        return p;
    }
    public static void main(String[] args) {
    assert(f((1l)).equals(("snts")));
    }

}
