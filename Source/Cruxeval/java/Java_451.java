import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import java.util.*;

class Java_451 {
    public static String f(String text, String character) {
        char[] textArray = text.toCharArray();
        for (int i = 0; i < textArray.length; i++) {
            if (String.valueOf(textArray[i]).equals(character)) {
                textArray[i] = '\0';
                return new String(textArray).replaceAll("\0", "");
            }
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("pn"), ("p")).equals(("n")));
    }

}
