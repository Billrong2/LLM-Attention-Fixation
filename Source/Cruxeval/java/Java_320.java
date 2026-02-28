import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;

class Java_320 {
    public static String f(String text) {
        int index = 1;
        while (index < text.length()) {
            if (text.charAt(index) != text.charAt(index - 1)) {
                index += 1;
            } else {
                String text1 = text.substring(0, index);
                String text2 = swapCase(text.substring(index));
                return text1 + text2;
            }
        }
        return swapCase(text);
    }

    private static String swapCase(String str) {
        StringBuilder builder = new StringBuilder();
        for (char c : str.toCharArray()) {
            if (Character.isUpperCase(c)) {
                builder.append(Character.toLowerCase(c));
            } else {
                builder.append(Character.toUpperCase(c));
            }
        }
        return builder.toString();
    }
    public static void main(String[] args) {
    assert(f(("USaR")).equals(("usAr")));
    }

}
