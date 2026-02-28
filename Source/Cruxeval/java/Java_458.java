import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.*;
import org.javatuples.*;
class Java_458 {
    public static String f(String text, String search_chars, String replace_chars) {
        Map<Character, Character> transMap = new HashMap<>();
        for (int i = 0; i < search_chars.length(); i++) {
            transMap.put(search_chars.charAt(i), replace_chars.charAt(i));
        }

        StringBuilder result = new StringBuilder();
        for (char c : text.toCharArray()) {
            result.append(transMap.getOrDefault(c, c));
        }

        return result.toString();
    }
    public static void main(String[] args) {
    assert(f(("mmm34mIm"), ("mm3"), (",po")).equals(("pppo4pIp")));
    }

}
