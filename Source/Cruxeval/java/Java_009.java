import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_009 {
    public static boolean f(String t) {
        for (char c : t.toCharArray()) {
            if (!Character.isDigit(c)) {
                return false;
            }
        }
        return true;
    }
    public static void main(String[] args) {
    assert(f(("#284376598")) == (false));
    }

}
