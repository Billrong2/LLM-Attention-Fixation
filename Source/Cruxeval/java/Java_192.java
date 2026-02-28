import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_192 {
    public static String f(String text, String suffix) {
        String output = text;
        while (text.endsWith(suffix)) {
            output = text.substring(0, text.length() - suffix.length());
            text = output;
        }
        return output;
    }
    public static void main(String[] args) {
    assert(f(("!klcd!ma:ri"), ("!")).equals(("!klcd!ma:ri")));
    }

}
