import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_590 {
    public static String f(String text) {
        for (int i = 10; i > 0; i--) {
            text = text.replaceFirst("^" + i, "");
        }
        return text;
    }
    public static void main(String[] args) {
    assert(f(("25000   $")).equals(("5000   $")));
    }

}
