import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_230 {
    public static String f(String text) {
        String result = "";
        int i = text.length() - 1;
        while (i >= 0) {
            char c = text.charAt(i);
            if (Character.isLetter(c)) {
                result += c;
            }
            i--;
        }
        return result;
    }
    public static void main(String[] args) {
    assert(f(("102x0zoq")).equals(("qozx")));
    }

}
