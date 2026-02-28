import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_699 {
    public static ArrayList<String> f(String text, String elem) {
        if (!elem.equals("")) {
            while (text.startsWith(elem)) {
                text = text.replaceFirst(elem, "");
            }
            while (elem.startsWith(text)) {
                elem = elem.replaceFirst(text, "");
            }
        }
        ArrayList<String> result = new ArrayList<>();
        result.add(elem);
        result.add(text);
        return result;
    }
    public static void main(String[] args) {
    assert(f(("some"), ("1")).equals((new ArrayList<String>(Arrays.asList((String)"1", (String)"some")))));
    }

}
