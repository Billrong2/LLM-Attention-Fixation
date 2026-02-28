import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_523 {
    public static String f(String text) {
        char[] newText = new char[text.length() * 6]; // allocate enough space for the new characters
        int j = 0;
        for (int i = 0; i < text.length(); i++) {
            char c = text.charAt(i);
            if (Character.isWhitespace(c)) {
                newText[j++] = '&';
                newText[j++] = 'n';
                newText[j++] = 'b';
                newText[j++] = 's';
                newText[j++] = 'p';
                newText[j++] = ';';
            } else {
                newText[j++] = c;
            }
        }
        return new String(newText, 0, j); // return the substring of the newText array that contains the characters
    }
    public static void main(String[] args) {
    assert(f(("   ")).equals(("&nbsp;&nbsp;&nbsp;")));
    }

}
