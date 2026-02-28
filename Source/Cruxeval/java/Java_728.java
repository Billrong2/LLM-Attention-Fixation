import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_728 {
    public static String f(String text) {
        List<Character> result = new ArrayList<>();
        for (int i = 0; i < text.length(); i++) {
            char ch = text.charAt(i);
            if (ch == Character.toLowerCase(ch)) {
                continue;
            }
            if (text.length() - 1 - i < text.lastIndexOf(Character.toLowerCase(ch))) {
                result.add(ch);
            }
        }
        StringBuilder sb = new StringBuilder();
        for (char ch : result) {
            sb.append(ch);
        }
        return sb.toString();
    }
    public static void main(String[] args) {
    assert(f(("ru")).equals(("")));
    }

}
