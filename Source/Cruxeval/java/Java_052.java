import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_052 {
    public static String f(String text) {
        List<Character> a = new ArrayList<>();
        for (int i = 0; i < text.length(); i++) {
            if (!Character.isDigit(text.charAt(i))) {
                a.add(text.charAt(i));
            }
        }
        StringBuilder sb = new StringBuilder();
        for (char c : a) {
            sb.append(c);
        }
        return sb.toString();
    }
    public static void main(String[] args) {
    assert(f(("seiq7229 d27")).equals(("seiq d")));
    }

}
