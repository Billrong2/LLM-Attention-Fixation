import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_388 {
    public static String f(String text, String characters) {
        List<Character> character_list = new ArrayList<>();
        for (char c : characters.toCharArray()) {
            character_list.add(c);
        }
        character_list.add(' ');
        character_list.add('_');

        int i = 0;
        while (i < text.length() && character_list.contains(text.charAt(i))) {
            i += 1;
        }

        return text.substring(i);
    }
    public static void main(String[] args) {
    assert(f(("2nm_28in"), ("nm")).equals(("2nm_28in")));
    }

}
