import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_215 {
    public static String f(String text) {
        String new_text = text;
        while (text.length() > 1 && text.charAt(0) == text.charAt(text.length() - 1)) {
            new_text = text = text.substring(1, text.length() - 1);
        }
        return new_text;
    }
    public static void main(String[] args) {
    assert(f((")")).equals((")")));
    }

}
