import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_259 {
    public static String f(String text) {
        List<Character> new_text = new ArrayList<>();
        for (int i = 0; i < text.length(); i++) {
            char character = text.charAt(i);
            if (Character.isUpperCase(character)) {
                new_text.add(new_text.size() / 2, character);
            }
        }
        if (new_text.size() == 0) {
            new_text.add('-');
        }
        StringBuilder result = new StringBuilder();
        for (char c : new_text) {
            result.append(c);
        }
        return result.toString();
    }
    public static void main(String[] args) {
    assert(f(("String matching is a big part of RexEx library.")).equals(("RES")));
    }

}
