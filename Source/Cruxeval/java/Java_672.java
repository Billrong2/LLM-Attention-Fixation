import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_672 {
    public static String f(String text, long position, String value) {
        int length = text.length();
        int index = (int)(position % (length + 2)) - 1;
        if (index >= length || index < 0) {
            return text;
        }
        char[] textArray = text.toCharArray();
        textArray[index] = value.charAt(0);
        return new String(textArray);
    }
    public static void main(String[] args) {
    assert(f(("1zd"), (0l), ("m")).equals(("1zd")));
    }

}
