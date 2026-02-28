import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import java.util.*;

class Java_764 {
    public static String f(String text, String old, String replacement) {
        String text2 = text.replaceAll(old, replacement);
        StringBuilder oldReverse = new StringBuilder(old).reverse();
        String old2 = oldReverse.toString();
        while (text2.contains(old2)) {
            text2 = text2.replaceAll(old2, replacement);
        }
        return text2;
    }
    public static void main(String[] args) {
    assert(f(("some test string"), ("some"), ("any")).equals(("any test string")));
    }

}
