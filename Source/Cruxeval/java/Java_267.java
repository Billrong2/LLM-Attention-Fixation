import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_267 {
    public static String f(String text, long space) {
        if (space < 0) {
            return text;
        }
        return String.format("%-" + (text.length() / 2 + space) + "s", text);
    }
    public static void main(String[] args) {
    assert(f(("sowpf"), (-7l)).equals(("sowpf")));
    }

}
