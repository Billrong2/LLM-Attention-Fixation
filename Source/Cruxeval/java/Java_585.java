import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_585 {
    public static String f(String text) {
        int count = 0;
        char firstChar = text.charAt(0);
        for (int i = 0; i < text.length(); i++) {
            if (text.charAt(i) == firstChar) {
                count++;
            } else {
                break;
            }
        }
        char[] chars = text.toCharArray();
        for (int i = 0; i < count; i++) {
            chars[i] = ' ';
        }
        return new String(chars).trim();
    }
    public static void main(String[] args) {
    assert(f((";,,,?")).equals((",,,?")));
    }

}
