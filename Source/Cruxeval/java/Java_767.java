import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_767 {
    public static String f(String text) {
        String[] a = text.trim().split(" ");
        for (int i = 0; i < a.length; i++) {
            if (!a[i].matches("\\d+")) {
                return "-";
            }
        }
        return String.join(" ", a);
    }
    public static void main(String[] args) {
    assert(f(("d khqw whi fwi bbn 41")).equals(("-")));
    }

}
