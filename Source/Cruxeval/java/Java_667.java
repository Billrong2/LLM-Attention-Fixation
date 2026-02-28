import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_667 {
    public static ArrayList<String> f(String text) {
        ArrayList<String> new_text = new ArrayList<>();
        for (int i = 0; i < text.length() / 3; i++) {
            new_text.add("< " + text.substring(i * 3, i * 3 + 3) + " level=" + i + " >");
        }
        String last_item = text.substring(text.length() / 3 * 3);
        new_text.add("< " + last_item + " level=" + text.length() / 3 + " >");
        return new_text;
    }
    public static void main(String[] args) {
    assert(f(("C7")).equals((new ArrayList<String>(Arrays.asList((String)"< C7 level=0 >")))));
    }

}
