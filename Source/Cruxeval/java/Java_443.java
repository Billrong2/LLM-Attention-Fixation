import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_443 {
    public static String f(String text) {
        for (int i = 0; i < text.length(); i++) {
            if (text.charAt(i) == ' ') {
                text = text.strip();
            } else {
                text = text.replace("cd", String.valueOf(text.charAt(i)));
            }
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("lorem ipsum")).equals(("lorem ipsum")));
    }

}
