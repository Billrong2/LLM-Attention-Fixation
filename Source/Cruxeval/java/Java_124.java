import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_124 {
    public static String f(String txt, String sep, long sep_count) {
        String o = "";
        while (sep_count > 0 && txt.contains(sep)) {
            o += txt.substring(0, txt.lastIndexOf(sep) + sep.length());
            txt = txt.substring(txt.lastIndexOf(sep) + sep.length());
            sep_count--;
        }
        return o + txt;
    }
    public static void main(String[] args) {
    assert(f(("i like you"), (" "), (-1l)).equals(("i like you")));
    }

}
