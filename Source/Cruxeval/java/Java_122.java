import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_122 {
    public static String f(String string) {
        if (!string.substring(0, 4).equals("Nuva")) {
            return "no";
        } else {
            return string.trim();
        }
    }
    public static void main(String[] args) {
    assert(f(("Nuva?dlfuyjys")).equals(("Nuva?dlfuyjys")));
    }

}
