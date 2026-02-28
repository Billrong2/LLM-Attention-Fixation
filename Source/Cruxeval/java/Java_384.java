import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_384 {
    public static String f(String text, String chars) {
        char[] charArray = chars.toCharArray();
        char[] textArray = text.toCharArray();
        List<Character> charList = new ArrayList<>();
        for (char c : charArray) {
            charList.add(c);
        }
        List<Character> newText = new ArrayList<>();
        for (char c : textArray) {
            newText.add(c);
        }
        while (newText.size() > 0 && textArray.length > 0) {
            if (charList.contains(newText.get(0))) {
                newText.remove(0);
            } else {
                break;
            }
        }
        StringBuilder result = new StringBuilder();
        for (char c : newText) {
            result.append(c);
        }
        return result.toString();
    }
    public static void main(String[] args) {
    assert(f(("asfdellos"), ("Ta")).equals(("sfdellos")));
    }

}
