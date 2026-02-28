import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_340 {
    public static String f(String text) {
        int uppercaseIndex = text.indexOf('A');
        if (uppercaseIndex >= 0) {
            return text.substring(0, uppercaseIndex) + text.substring(text.indexOf('a') + 1);
        } else {
            char[] sortedChars = text.toCharArray();
            Arrays.sort(sortedChars);
            return new String(sortedChars);
        }
    }
    public static void main(String[] args) {
    assert(f(("E jIkx HtDpV G")).equals(("   DEGHIVjkptx")));
    }

}
