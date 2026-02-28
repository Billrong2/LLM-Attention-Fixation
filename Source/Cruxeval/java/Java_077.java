import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_077 {
    public static String f(String text, String character) {
        int index = text.lastIndexOf(character);
        if (index != -1) {
            String subject = text.substring(index);
            int count = (int) text.chars().filter(ch -> ch == character.charAt(0)).count();
            return subject.repeat(count);
        } else {
            return "";
        }
    }
    public static void main(String[] args) {
    assert(f(("h ,lpvvkohh,u"), ("i")).equals(("")));
    }

}
