import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_244 {
    public static String f(String text, String symbols) {
        int count = 0;
        if (!symbols.isEmpty()) {
            count = symbols.length();
            text = String.join("", Collections.nCopies(count, text));
        }
        return String.format("%1$" + (text.length() + count*2) + "s", text).substring(0, text.length() + count*2 - 2);
    }
    public static void main(String[] args) {
    assert(f((""), ("BC1ty")).equals(("        ")));
    }

}
