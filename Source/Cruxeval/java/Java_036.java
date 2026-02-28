import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_036 {
    public static String f(String text, String chars) {
        if (text == null) {
            return null;
        }
        int end = text.length();
        while (end > 0 && chars.indexOf(text.charAt(end - 1)) != -1) {
            end--;
        }
        return text.substring(0, end);
    }
    public static void main(String[] args) {
    assert(f(("ha"), ("")).equals(("ha")));
    }

}
