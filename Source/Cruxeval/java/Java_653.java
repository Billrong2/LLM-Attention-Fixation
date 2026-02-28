import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_653 {
    public static long f(String text, String letter) {
        String t = text;
        for (char alph : text.toCharArray()) {
            t = t.replace(String.valueOf(alph), "");
        }
        return t.split(letter).length;
    }
    public static void main(String[] args) {
    assert(f(("c, c, c ,c, c"), ("c")) == (1l));
    }

}
