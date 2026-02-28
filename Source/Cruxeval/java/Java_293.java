import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_293 {
    public static String f(String text) {
        String s = text.toLowerCase();
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == 'x') {
                return "no";
            }
        }
        return text.toUpperCase();
    }
    public static void main(String[] args) {
    assert(f(("dEXE")).equals(("no")));
    }

}
