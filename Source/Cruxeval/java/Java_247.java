import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_247 {
    public static String f(String s) {
        if (s.matches("[a-zA-Z]+")) {
            return "yes";
        }
        if (s.equals("")) {
            return "str is empty";
        }
        return "no";
    }
    public static void main(String[] args) {
    assert(f(("Boolean")).equals(("yes")));
    }

}
