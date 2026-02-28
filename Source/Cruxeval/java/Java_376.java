import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_376 {
    public static String f(String text) {
        for (int i = 1; i <= text.length(); i++) {
            if (text.substring(0, i).startsWith("two")) {
                return text.substring(i);
            }
        }
        return "no";
    }
    public static void main(String[] args) {
    assert(f(("2two programmers")).equals(("no")));
    }

}
