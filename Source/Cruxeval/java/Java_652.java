import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_652 {
    public static String f(String string) {
        if (string.isEmpty() || !Character.isDigit(string.charAt(0))) {
            return "INVALID";
        }
        int cur = 0;
        for (int i = 0; i < string.length(); i++) {
            cur = cur * 10 + Character.getNumericValue(string.charAt(i));
        }
        return String.valueOf(cur);
    }
    public static void main(String[] args) {
    assert(f(("3")).equals(("3")));
    }

}
