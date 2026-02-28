import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import java.util.*;

class Java_537 {
    public static String f(String text, String value) {
        char[] new_text = text.toCharArray();
        int length = 0;
        try {
            StringBuilder sb = new StringBuilder();
            for (char c : new_text) {
                sb.append(c);
            }
            sb.append(value);
            length = sb.length();
        } catch (IndexOutOfBoundsException e) {
            length = 0;
        }
        return "[" + String.valueOf(length) + "]";
    }
    public static void main(String[] args) {
    assert(f(("abv"), ("a")).equals(("[4]")));
    }

}
