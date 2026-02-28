import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_129 {
    public static ArrayList<Long> f(String text, String search_string) {
        ArrayList<Long> indexes = new ArrayList<>();
        while (text.contains(search_string)) {
            indexes.add((long)text.lastIndexOf(search_string));
            text = text.substring(0, text.lastIndexOf(search_string));
        }
        return indexes;
    }
    public static void main(String[] args) {
    assert(f(("ONBPICJOHRHDJOSNCPNJ9ONTHBQCJ"), ("J")).equals((new ArrayList<Long>(Arrays.asList((long)28l, (long)19l, (long)12l, (long)6l)))));
    }

}
