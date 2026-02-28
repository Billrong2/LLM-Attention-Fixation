import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_651 {
    public static String f(String text, String letter) {
        if (Character.isLowerCase(letter.charAt(0))) {
            letter = letter.toUpperCase();
        }
        char[] charArray = text.toCharArray();
        for (int i = 0; i < text.length(); i++) {
            if (Character.toLowerCase(charArray[i]) == letter.charAt(0)) {
                charArray[i] = letter.charAt(0);
            }
        }
        String newText = new String(charArray);
        return newText.substring(0, 1).toUpperCase() + newText.substring(1);
    }
    public static void main(String[] args) {
    assert(f(("E wrestled evil until upperfeat"), ("e")).equals(("E wrestled evil until upperfeat")));
    }

}
