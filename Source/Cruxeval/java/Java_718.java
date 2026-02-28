import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_718 {
    public static String f(String text) {
        String t = text;
        for (char i : text.toCharArray()) {
            text = text.replace(String.valueOf(i), "");
        }
        return String.valueOf(text.length()) + t;
    }
    public static void main(String[] args) {
    assert(f(("ThisIsSoAtrocious")).equals(("0ThisIsSoAtrocious")));
    }

}
