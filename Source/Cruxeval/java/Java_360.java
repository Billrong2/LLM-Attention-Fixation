import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_360 {
    public static String f(String text, long n) {
        if (text.length() <= 2) {
            return text;
        }
        char leadingChar = text.charAt(0);
        StringBuilder leadingChars = new StringBuilder();
        for (int i = 0; i < n - text.length() + 1; i++) {
            leadingChars.append(leadingChar);
        }
        return leadingChars.toString() + text.substring(1, text.length() - 1) + text.charAt(text.length() - 1);
    }
    public static void main(String[] args) {
    assert(f(("g"), (15l)).equals(("g")));
    }

}
