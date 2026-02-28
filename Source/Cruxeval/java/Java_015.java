import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_015 {
    public static String f(String text, String wrong, String right) {
        String new_text = text.replace(wrong, right);
        return new_text.toUpperCase();
    }
    public static void main(String[] args) {
    assert(f(("zn kgd jw lnt"), ("h"), ("u")).equals(("ZN KGD JW LNT")));
    }

}
