import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_220 {
    public static String f(String text, long m, long n) {
        text = text + text.substring(0, (int)m) + text.substring((int)n);
        String result = "";
        for (int i = (int)n; i < text.length() - m; i++) {
            result = text.charAt(i) + result;
        }
        return result;
    }
    public static void main(String[] args) {
    assert(f(("abcdefgabc"), (1l), (2l)).equals(("bagfedcacbagfedc")));
    }

}
