import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_671 {
    public static String f(String text, String char1, String char2) {
        char[] t1a = new char[char1.length()];
        char[] t2a = new char[char2.length()];
        for (int i = 0; i < char1.length(); i++) {
            t1a[i] = char1.charAt(i);
            t2a[i] = char2.charAt(i);
        }
        Map<Character, Character> map = new HashMap<>();
        for (int i = 0; i < t1a.length; i++) {
            map.put(t1a[i], t2a[i]);
        }
        StringBuilder sb = new StringBuilder();
        for (char c : text.toCharArray()) {
            sb.append(map.getOrDefault(c, c));
        }
        return sb.toString();
    }
    public static void main(String[] args) {
    assert(f(("ewriyat emf rwto segya"), ("tey"), ("dgo")).equals(("gwrioad gmf rwdo sggoa")));
    }

}
