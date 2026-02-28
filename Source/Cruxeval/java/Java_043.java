import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_043 {
    public static long f(String n) {
        for (int i = 0; i < n.length(); i++) {
            if (!Character.isDigit(n.charAt(i))) {
                return -1;
            }
        }
        return Integer.parseInt(n);
    }
    public static void main(String[] args) {
    assert(f(("6 ** 2")) == (-1l));
    }

}
