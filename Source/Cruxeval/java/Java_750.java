import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_750 {
    public static String f(HashMap<String,String> char_map, String text) {
        StringBuilder new_text = new StringBuilder();
        for (int i = 0; i < text.length(); i++) {
            String ch = String.valueOf(text.charAt(i));
            String val = char_map.get(ch);
            if (val == null) {
                new_text.append(ch);
            } else {
                new_text.append(val);
            }
        }
        return new_text.toString();
    }
    public static void main(String[] args) {
    assert(f((new HashMap<String,String>()), ("hbd")).equals(("hbd")));
    }

}
