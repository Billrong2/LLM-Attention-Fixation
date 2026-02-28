import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_169 {
    public static String f(String text) {
        char[] ls = text.toCharArray();
        int total = (text.length() - 1) * 2;
        for (int i = 1; i <= total; i++) {
            if (i % 2 == 1) {
                ls = Arrays.copyOf(ls, ls.length + 1);
                ls[ls.length - 1] = '+';
            } else {
                char[] newLs = new char[ls.length + 1];
                newLs[0] = '+';
                System.arraycopy(ls, 0, newLs, 1, ls.length);
                ls = newLs;
            }
        }
        StringBuilder result = new StringBuilder();
        for (char c : ls) {
            result.append(c);
        }
        return result.toString();
    }
    public static void main(String[] args) {
    assert(f(("taole")).equals(("++++taole++++")));
    }

}
