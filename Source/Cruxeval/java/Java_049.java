import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_049 {
    public static String f(String text) {
        if (text.matches("\\w+")) {
            return text.replaceAll("\\D", "");
        } else {
            return text;
        }
    }
    public static void main(String[] args) {
    assert(f(("816")).equals(("816")));
    }

}
