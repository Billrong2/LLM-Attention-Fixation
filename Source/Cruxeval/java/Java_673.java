import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_673 {
    public static String f(String string) {
        if (string.equals(string.toUpperCase())) {
            return string.toLowerCase();
        } else if (string.equals(string.toLowerCase())) {
            return string.toUpperCase();
        }
        return string;
    }
    public static void main(String[] args) {
    assert(f(("cA")).equals(("cA")));
    }

}
