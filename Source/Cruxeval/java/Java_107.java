import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_107 {
    public static String f(String text) {
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < text.length(); i++) {
            char currentChar = text.charAt(i);
            if (currentChar > 127) {
                return "False";
            } else if (Character.isLetterOrDigit(currentChar)) {
                result.append(Character.toUpperCase(currentChar));
            } else {
                result.append(currentChar);
            }
        }
        return result.toString();
    }
    public static void main(String[] args) {
    assert(f(("ua6hajq")).equals(("UA6HAJQ")));
    }

}
