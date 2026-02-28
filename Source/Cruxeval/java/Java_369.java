import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_369 {
    public static String f(String var) {
        if (var.matches("\\d+")) {
            return "int";
        } else if (var.replaceFirst("\\.", "").matches("\\d+")) {
            return "float";
        } else if (var.replaceAll("\\s", "").isEmpty()) {
            return "str";
        } else if (var.length() == 1) {
            return "char";
        } else {
            return "tuple";
        }
    }
    public static void main(String[] args) {
    assert(f((" 99 777")).equals(("tuple")));
    }

}
