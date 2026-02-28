import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_292 {
    public static String f(String text) {
        char[] new_text = new char[text.length()];
        for (int i = 0; i < text.length(); i++) {
            char c = text.charAt(i);
            new_text[i] = Character.isDigit(c) ? c : '*';
        }
        return new String(new_text);
    }
    public static void main(String[] args) {
    assert(f(("5f83u23saa")).equals(("5*83*23***")));
    }

}
