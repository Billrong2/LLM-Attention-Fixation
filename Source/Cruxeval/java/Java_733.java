import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_733 {
    public static String f(String text) {
        int length = text.length() / 2;
        String left_half = text.substring(0, length);
        String right_half = new StringBuilder(text.substring(length)).reverse().toString();
        return left_half + right_half;
    }
    public static void main(String[] args) {
    assert(f(("n")).equals(("n")));
    }

}
