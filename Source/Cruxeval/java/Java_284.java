import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_284 {
    public static String f(String text, String prefix) {
        int idx = 0;
        for (char letter : prefix.toCharArray()) {
            if (text.charAt(idx) != letter) {
                return null;
            }
            idx++;
        }
        return text.substring(idx);
    }
    public static void main(String[] args) {
    assert(f(("bestest"), ("bestest")).equals(("")));
    }

}
