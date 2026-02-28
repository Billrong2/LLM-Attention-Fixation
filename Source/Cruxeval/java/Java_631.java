import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_631 {
    public static String f(String text, long num) {
        int req = (int)num - text.length();
        text = String.format("%" + num + "s", text).replace(' ', '*');
        return text.substring(req / 2, (req / 2) + text.length() - req);
    }
    public static void main(String[] args) {
    assert(f(("a"), (19l)).equals(("*")));
    }

}
