import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_254 {
    public static String f(String text, String repl) {
        Map<Character, Character> trans = new HashMap<>();
        for (int i = 0; i < text.length(); i++) {
            trans.put(Character.toLowerCase(text.charAt(i)), Character.toLowerCase(repl.charAt(i)));
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < text.length(); i++) {
            sb.append(trans.getOrDefault(Character.toLowerCase(text.charAt(i)), text.charAt(i)));
        }
        return sb.toString();
    }
    public static void main(String[] args) {
    assert(f(("upper case"), ("lower case")).equals(("lwwer case")));
    }

}
