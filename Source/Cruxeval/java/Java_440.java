import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_440 {
    public static String f(String text) {
        if (text.matches("\\d+")) {
            return "yes";
        } else {
            return "no";
        }
    }
    public static void main(String[] args) {
    assert(f(("abc")).equals(("no")));
    }

}
