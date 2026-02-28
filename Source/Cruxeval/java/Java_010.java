import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_010 {
    public static String f(String text) {
        String new_text = "";
        for (char ch : text.toLowerCase().trim().toCharArray()) {
            if (Character.isDigit(ch) || ch == 'ä' || ch == 'ö' || ch == 'ü' || ch == 'ï') {
                new_text += ch;
            }
        }
        return new_text;
    }
    public static void main(String[] args) {
    assert(f(("")).equals(("")));
    }

}
