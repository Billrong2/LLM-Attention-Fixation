import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_629 {
    public static String f(String text, String dng) {
        if (!text.contains(dng)) {
            return text;
        }
        if (text.substring(text.length() - dng.length()).equals(dng)) {
            return text.substring(0, text.length() - dng.length());
        }
        return text.substring(0, text.length() - 1) + f(text.substring(0, text.length() - 2), dng);
    }
    public static void main(String[] args) {
    assert(f(("catNG"), ("NG")).equals(("cat")));
    }

}
