import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_311 {
    public static String f(String text) {
        text = text.replace("#", "1").replace("$", "5");
        return text.matches("\\d+") ? "yes" : "no";
    }
    public static void main(String[] args) {
    assert(f(("A")).equals(("no")));
    }

}
