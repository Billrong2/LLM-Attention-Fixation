import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_462 {
    public static String f(String text, String value) {
        int length = text.length();
        char[] letters = text.toCharArray();
        if (text.indexOf(value) == -1) {
            value = String.valueOf(letters[0]);
        }
        return value.repeat(length);
    }
    public static void main(String[] args) {
    assert(f(("ldebgp o"), ("o")).equals(("oooooooo")));
    }

}
