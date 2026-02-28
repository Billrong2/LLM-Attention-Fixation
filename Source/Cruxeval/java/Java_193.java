import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_193 {
    public static String f(String string) {
        int count = (int) string.chars().filter(ch -> ch == ':').count();
        return string.replaceFirst("(:){" + (count - 1) + "}", "");
    }
    public static void main(String[] args) {
    assert(f(("1::1")).equals(("1:1")));
    }

}
