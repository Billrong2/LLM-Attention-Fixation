import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_501 {
    public static String f(String text, String ch) {
        int index = text.lastIndexOf(ch);
        char[] result = text.toCharArray();
        while (index > 0) {
            result[index] = result[index - 1];
            result[index - 1] = ch.charAt(0);
            index -= 2;
        }
        return new String(result);
    }
    public static void main(String[] args) {
    assert(f(("qpfi jzm"), ("j")).equals(("jqjfj zm")));
    }

}
