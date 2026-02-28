import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_505 {
    public static String f(String string) {
        while (string.length() > 0) {
            if (Character.isLetter(string.charAt(string.length() - 1))) {
                return string;
            }
            string = string.substring(0, string.length() - 1);
        }
        return string;
    }
    public static void main(String[] args) {
    assert(f(("--4/0-209")).equals(("")));
    }

}
