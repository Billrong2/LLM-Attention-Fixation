import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_154 {
    public static String f(String s, String c) {
        String[] splitS = s.split(" ");
        StringBuilder result = new StringBuilder(c + "  ");
        for (int i = splitS.length - 1; i >= 0; i--) {
            result.append(splitS[i]);
            if (i > 0) {
                result.append("  ");
            }
        }
        return result.toString();
    }
    public static void main(String[] args) {
    assert(f(("Hello There"), ("*")).equals(("*  There  Hello")));
    }

}
