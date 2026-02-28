import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_409 {
    public static String f(String text, String charStr) {
        char charPrefix = charStr.charAt(0);
        if (text.length() > 0) {
            text = text.replaceFirst("^" + charPrefix, "");
            text = text.replaceFirst("^" + text.charAt(text.length() - 1), "");
            text = text.substring(0, text.length() - 1) + Character.toUpperCase(text.charAt(text.length() - 1));
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("querist"), ("u")).equals(("querisT")));
    }

}
