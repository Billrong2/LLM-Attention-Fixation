import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_138 {
    public static String f(String text, String chars) {
        List<Character> listchars = new ArrayList<>();
        for(char c : chars.toCharArray()) {
            listchars.add(c);
        }
        char first = listchars.remove(listchars.size() - 1);
        for(char i : listchars) {
            text = text.substring(0, text.indexOf(i)) + i + text.substring(text.indexOf(i) + 1);
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("tflb omn rtt"), ("m")).equals(("tflb omn rtt")));
    }

}
