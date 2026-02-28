import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_755 {
    public static String f(String replace, String text, String hide) {
        while (text.contains(hide)) {
            replace += "ax";
            text = text.replaceFirst(hide, replace);
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("###"), ("ph>t#A#BiEcDefW#ON#iiNCU"), (".")).equals(("ph>t#A#BiEcDefW#ON#iiNCU")));
    }

}
