import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_665 {
    public static String f(String chars) {
        StringBuilder s = new StringBuilder();
        for (int i = 0; i < chars.length(); i++) {
            char ch = chars.charAt(i);
            if (chars.chars().filter(c -> c == ch).count() % 2 == 0) {
                s.append(Character.toUpperCase(ch));
            } else {
                s.append(ch);
            }
        }
        return s.toString();
    }
    public static void main(String[] args) {
    assert(f(("acbced")).equals(("aCbCed")));
    }

}
