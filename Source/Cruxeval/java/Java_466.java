import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_466 {
    public static String f(String text) {
        int length = text.length();
        int index = 0;
        while (index < length && Character.isWhitespace(text.charAt(index))) {
            index++;
        }
        return text.substring(index, Math.min(index + 5, length));
    }
    public static void main(String[] args) {
    assert(f(("-----	\n	th\n-----")).equals(("-----")));
    }

}
