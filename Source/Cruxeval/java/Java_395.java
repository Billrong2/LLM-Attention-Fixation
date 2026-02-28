import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_395 {
    public static long f(String s) {
        for (int i = 0; i < s.length(); i++) {
            if (Character.isDigit(s.charAt(i))) {
                return i + (s.charAt(i) == '0' ? 1 : 0);
            } else if (s.charAt(i) == '0') {
                return -1;
            }
        }
        return -1;
    }
    public static void main(String[] args) {
    assert(f(("11")) == (0l));
    }

}
