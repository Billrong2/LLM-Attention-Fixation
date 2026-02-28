import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_674 {
    public static String f(String text) {
        char[] ls = text.toCharArray();
        for (int x = ls.length - 1; x >= 0; x--) {
            if (ls.length <= 1) break;
            if ("zyxwvutsrqponmlkjihgfedcba".indexOf(ls[x]) == -1) {
                text = text.substring(0, x) + text.substring(x + 1);
            }
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("qq")).equals(("qq")));
    }

}
