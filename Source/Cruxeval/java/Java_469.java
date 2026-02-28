import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_469 {
    public static String f(String text, long position, String value) {
        int length = text.length();
        int index = (int)(position % length);
        if (position < 0) {
            index = length / 2;
        }
        List<Character> newText = new ArrayList<>();
        for (char c : text.toCharArray()) {
            newText.add(c);
        }
        newText.add(index, value.charAt(0));
        newText.remove(length - 1);
        
        StringBuilder sb = new StringBuilder();
        for (char c : newText) {
            sb.append(c);
        }
        return sb.toString();
    }
    public static void main(String[] args) {
    assert(f(("sduyai"), (1l), ("y")).equals(("syduyi")));
    }

}
