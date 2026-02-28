import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_642 {
    public static String f(String text) {
        int i = 0;
        while (i < text.length() && Character.isWhitespace(text.charAt(i))) {
            i++;
        }
        if (i == text.length()) {
            return "space";
        }
        return "no";
    }
    public static void main(String[] args) {
    assert(f(("     ")).equals(("space")));
    }

}
