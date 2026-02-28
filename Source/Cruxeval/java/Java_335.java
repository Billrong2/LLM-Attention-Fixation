import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_335 {
    public static String f(String text, String to_remove) {
        char[] new_text = text.toCharArray();
        if (text.contains(to_remove)) {
            int index = text.indexOf(to_remove);
            new_text[index] = '?';
            String result = new String(new_text);
            return result.replace("?", "");
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("sjbrlfqmw"), ("l")).equals(("sjbrfqmw")));
    }

}
