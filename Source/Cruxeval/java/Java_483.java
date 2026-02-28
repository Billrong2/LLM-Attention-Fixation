import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_483 {
    public static String f(String text, String character) {
        return String.join(" ", text.split(character, -1));
    }
    public static void main(String[] args) {
    assert(f(("a"), ("a")).equals((" ")));
    }

}
