import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_449 {
    public static boolean f(String x) {
        int n = x.length();
        int i = 0;
        while (i < n && Character.isDigit(x.charAt(i))) {
            i++;
        }
        return i == n;
    }
    public static void main(String[] args) {
    assert(f(("1")) == (true));
    }

}
