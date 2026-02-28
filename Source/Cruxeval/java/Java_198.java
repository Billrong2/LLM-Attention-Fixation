import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.regex.Pattern;
import java.util.stream.*;
import org.javatuples.*;
class Java_198 {
    public static String f(String text, String strip_chars) {
        StringBuilder reversedText = new StringBuilder(text).reverse();
        String strippedText = reversedText.toString().replaceAll("^[" + Pattern.quote(strip_chars) + "]+|[" + Pattern.quote(strip_chars) + "]+$", "");
        return new StringBuilder(strippedText).reverse().toString();
    }
    public static void main(String[] args) {
    assert(f(("tcmfsmj"), ("cfj")).equals(("tcmfsm")));
    }

}
