import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_650 {
    public static String f(String string, String substring) {
        while (string.startsWith(substring)) {
            string = string.substring(substring.length());
        }
        return string;
    }
    public static void main(String[] args) {
    assert(f((""), ("A")).equals(("")));
    }

}
