import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_303 {
    public static String f(String text) {
        int i = (text.length() + 1) / 2;
        char[] result = text.toCharArray();
        while (i < text.length()) {
            char t = Character.toLowerCase(result[i]);
            if (t == result[i]) {
                i++;
            } else {
                result[i] = t;
            }
            i += 2;
        }
        return new String(result);
    }
    public static void main(String[] args) {
    assert(f(("mJkLbn")).equals(("mJklbn")));
    }

}
