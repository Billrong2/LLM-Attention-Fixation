import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_787 {
    public static String f(String text) {
        if (text.length() == 0) {
            return "";
        }
        text = text.toLowerCase();
        return Character.toUpperCase(text.charAt(0)) + text.substring(1);
    }
    public static void main(String[] args) {
    assert(f(("xzd")).equals(("Xzd")));
    }

}
