import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_162 {
    public static String f(String text) {
        String result = "";
        for (int i = 0; i < text.length(); i++) {
            char c = text.charAt(i);
            if (Character.isLetterOrDigit(c)) {
                result += Character.toUpperCase(c);
            }
        }
        return result;
    }
    public static void main(String[] args) {
    assert(f(("с bishop.Swift")).equals(("СBISHOPSWIFT")));
    }

}
